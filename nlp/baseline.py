import re
import os
import csv
import codecs
import pickle
import argparse
import sklearn
import scipy
# import pandas as pd

from nltk.corpus import stopwords
from nltk.stem import SnowballStemmer


parser = argparse.ArgumentParser()
parser.add_argument('--remove-stopword', action='store_true',
                    dest='REMOVE_STOPWORD', default=False)
parser.add_argument('--stemming', action='store_true',
                    dest='STEMMING', default=False)

args = parser.parse_args()
TRAIN_DATA_FILE = 'input/train.csv'
TEST_DATA_FILE = 'input/test.csv'

REMOVE_STOPWORD = args.REMOVE_STOPWORD
STEMMING = args.STEMMING

########################################
# process texts in datasets
########################################
print('Processing text dataset')


# https://www.kaggle.com/currie32/quora-question-pairs/the-importance-of-cleaning-text
# def text_to_wordlist(text, remove_stopwords=False, stem_words=False):
def text_to_wordlist(text, remove_stopwords, stem_words):
    # Clean the text, with the option to remove stopwords and to stem words.

    # Convert words to lower case and split them
    text = text.lower().split()

    # Optionally, remove stop words
    if remove_stopwords:
        stops = set(stopwords.words("english"))
        text = [w for w in text if w not in stops]

    text = " ".join(text)

    # Clean the text
    text = re.sub(r"[^A-Za-z0-9^,!.\/'+-=]", " ", text)
    text = re.sub(r"what's", "what is ", text)
    text = re.sub(r"\'s", " ", text)
    text = re.sub(r"\'ve", " have ", text)
    text = re.sub(r"can't", "cannot ", text)
    text = re.sub(r"n't", " not ", text)
    text = re.sub(r"i'm", "i am ", text)
    text = re.sub(r"\'re", " are ", text)
    text = re.sub(r"\'d", " would ", text)
    text = re.sub(r"\'ll", " will ", text)
    text = re.sub(r",", " ", text)
    text = re.sub(r"\.", " ", text)
    text = re.sub(r"!", " ! ", text)
    text = re.sub(r"\/", " ", text)
    text = re.sub(r"\^", " ^ ", text)
    text = re.sub(r"\+", " + ", text)
    text = re.sub(r"\-", " - ", text)
    text = re.sub(r"\=", " = ", text)
    text = re.sub(r"'", " ", text)
    text = re.sub(r"(\d+)(k)", r"\g<1>000", text)
    text = re.sub(r":", " : ", text)
    text = re.sub(r" e g ", " eg ", text)
    text = re.sub(r" b g ", " bg ", text)
    text = re.sub(r" u s ", " american ", text)
    text = re.sub(r"\0s", "0", text)
    text = re.sub(r" 9 11 ", "911", text)
    text = re.sub(r"e - mail", "email", text)
    text = re.sub(r"j k", "jk", text)
    text = re.sub(r"\s{2,}", " ", text)

    # Optionally, shorten words to their stems
    if stem_words:
        text = text.split()
        stemmer = SnowballStemmer('english')
        stemmed_words = [stemmer.stem(word) for word in text]
        text = " ".join(stemmed_words)

    return text


def preprop_train(input_fpath, remove_stopwords=True, stem_words=True):
    stop = '1' if remove_stopwords else '0'
    stem = '1' if stem_words else '0'
    fpath = f'work/{stop}_{stem}_train.pickle'

    if os.path.isfile(fpath):
        print('cache hit...')
        texts_1, texts_2, labels = pickle.load(open(fpath, 'rb'))
        return texts_1, texts_2, labels

    texts_1, texts_2, labels = ([], [], [])

    with codecs.open(input_fpath, encoding='utf-8') as f:
        reader = csv.reader(f, delimiter=',')
        next(reader)  # remove header
        for values in reader:
            texts_1.append(text_to_wordlist(values[3],
                                            remove_stopwords, stem_words))
            texts_2.append(text_to_wordlist(values[4],
                                            remove_stopwords, stem_words))
            labels.append(int(values[5]))

    pickle.dump((texts_1, texts_2, labels), open(fpath, 'wb'))
    return texts_1, texts_2, labels


def preprop_test(input_fpath, remove_stopwords=True, stem_words=True):
    stop = '1' if remove_stopwords else '0'
    stem = '1' if stem_words else '0'
    fpath = f'work/{stop}_{stem}_test.pickle'

    if os.path.isfile(fpath):
        print('cache hit...')
        test_texts_1, test_texts_2, test_ids = pickle.load(open(fpath, 'rb'))
        return test_texts_1, test_texts_2, test_ids

    test_texts_1, test_texts_2, test_ids = ([], [], [])
    with codecs.open(TEST_DATA_FILE, encoding='utf-8') as f:
        reader = csv.reader(f, delimiter=',')
        next(reader)  # remove header
        for values in reader:
            test_texts_1.append(text_to_wordlist(values[1],
                                                 remove_stopwords, stem_words))
            test_texts_2.append(text_to_wordlist(values[2],
                                                 remove_stopwords, stem_words))
            test_ids.append(values[0])

    pickle.dump((test_texts_1, test_texts_2, test_ids), open(fpath, 'wb'))
    return test_texts_1, test_texts_2, test_ids


# ------------
# model

print(f'remove_stopwords: {REMOVE_STOPWORD}')
print(f'stem_words: {STEMMING}')

texts_1, texts_2, labels = preprop_train(TRAIN_DATA_FILE,
                                         REMOVE_STOPWORD, STEMMING)
print('Found %s texts in train.csv' % len(texts_1))

test_texts_1, test_texts_2, test_ids = preprop_test(TEST_DATA_FILE,
                                                    REMOVE_STOPWORD, STEMMING)
print('Found %s texts in test.csv' % len(test_texts_1))

vectorizer = sklearn.feature_extraction.text.TfidfVectorizer()
vectorizer.fit(texts_1 + texts_2 + test_texts_1 + test_texts_2)

test_1_vec_list = vectorizer.transform(test_texts_1)
test_2_vec_list = vectorizer.transform(test_texts_2)

print('is_duplicate,test_id')
for test_id, test_1_vec, test_2_vec in zip(test_ids,
                                           test_1_vec_list,
                                           test_2_vec_list):

    sim = 1 - scipy.spatial.distance.cosine(test_1_vec.todense(),
                                            test_2_vec.todense())
    print(f'{sim},{test_id}')
