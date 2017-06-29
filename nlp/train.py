import re
import os
import csv
import codecs
import pickle
import argparse
import xgboost as xgb
import numpy as np
import pandas as pd

from nltk.corpus import stopwords
from nltk.stem import SnowballStemmer

from gensim.models import KeyedVectors
from keras.preprocessing.text import Tokenizer
from keras.preprocessing.sequence import pad_sequences
from keras.callbacks import EarlyStopping
from keras.callbacks import ModelCheckpoint
from keras.layers import Bidirectional
from keras.layers import Embedding
from keras.layers import Dense
from keras.layers import Conv1D
from keras.layers import LSTM
from keras.layers import Dropout
from keras.layers import Input
from keras.layers import concatenate
from keras.layers.normalization import BatchNormalization
from keras.models import Model


parser = argparse.ArgumentParser()
parser.add_argument('--embedding-model', type=str, dest='EMBEDDING_FILE',
                    default='input/glove.6B.300d.bin')
parser.add_argument('--max-sequence-len', type=int,
                    dest='MAX_SEQUENCE_LENGTH', default=30)
parser.add_argument('--max-nb-word', type=int,
                    dest='MAX_NB_WORD', default=200000)
parser.add_argument('--embedding-dim', type=int,
                    dest='EMBEDDING_DIM', default=300)
parser.add_argument('--validation-split', type=float,
                    dest='VALIDATION_SPLIT', default=0.1)
parser.add_argument('--nb-lstm', type=int,
                    dest='NB_LSTM', default=80)
parser.add_argument('--nb-dense', type=int,
                    dest='NB_DENSE', default=80)
parser.add_argument('--lstm-drop-rate', type=float,
                    dest='RATE_DROP_LSTM', default=0.3)
parser.add_argument('--dense-drop-rate', type=float,
                    dest='RATE_DROP_DENSE', default=0.3)
parser.add_argument('--stopword', action='store_true',
                    dest='STOPWORD', default=False)
parser.add_argument('--stemming', action='store_true',
                    dest='STEMMING', default=False)
parser.add_argument('--model', type=int, default=1, dest='MODEL',
                    help='blstm, cnn_blstm, blstm_xgb, cnn_blstm_xgb')

args = parser.parse_args()
TRAIN_DATA_FILE = 'input/train.csv'
TEST_DATA_FILE = 'input/test.csv'

EMBEDDING_FILE = args.EMBEDDING_FILE
MAX_SEQUENCE_LENGTH = args.MAX_SEQUENCE_LENGTH
MAX_NB_WORD = args.MAX_NB_WORD  # 200000 -> 150000
EMBEDDING_DIM = args.EMBEDDING_DIM
VALIDATION_SPLIT = args.VALIDATION_SPLIT

NB_LSTM = args.NB_LSTM
NB_DENSE = args.NB_DENSE
RATE_DROP_LSTM = args.RATE_DROP_LSTM
RATE_DROP_DENSE = args.RATE_DROP_DENSE

STOPWORD = args.STOPWORD
STEMMING = args.STEMMING

MODEL = args.MODEL

########################################
# index word vectors
########################################
print('Indexing word vectors')

try:
    word2vec = KeyedVectors.load_word2vec_format(EMBEDDING_FILE)

except UnicodeDecodeError:
    word2vec = KeyedVectors.load_word2vec_format(EMBEDDING_FILE,
                                                 binary=True)

print('Found %s word vectors of word2vec' % len(word2vec.vocab))

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


texts_1, texts_2, labels = preprop_train(TRAIN_DATA_FILE,
                                         STOPWORD, STEMMING)
print('Found %s texts in train.csv' % len(texts_1))

test_texts_1, test_texts_2, test_ids = preprop_test(TEST_DATA_FILE,
                                                    STOPWORD, STEMMING)
print('Found %s texts in test.csv' % len(test_texts_1))

tokenizer = Tokenizer(num_words=MAX_NB_WORD)
tokenizer.fit_on_texts(texts_1 + texts_2 + test_texts_1 + test_texts_2)

sequences_1 = tokenizer.texts_to_sequences(texts_1)
sequences_2 = tokenizer.texts_to_sequences(texts_2)
test_sequences_1 = tokenizer.texts_to_sequences(test_texts_1)
test_sequences_2 = tokenizer.texts_to_sequences(test_texts_2)

word_index = tokenizer.word_index
print('Found %s unique tokens' % len(word_index))

if MAX_SEQUENCE_LENGTH > 0:
    data_1 = pad_sequences(sequences_1, maxlen=MAX_SEQUENCE_LENGTH)
    data_2 = pad_sequences(sequences_2, maxlen=MAX_SEQUENCE_LENGTH)
else:
    data_1 = pad_sequences(sequences_1)
    MAX_SEQUENCE_LENGTH = data_1.shape[1]
    data_2 = pad_sequences(sequences_2, maxlen=MAX_SEQUENCE_LENGTH)
labels = np.array(labels)
print('Shape of data tensor:', data_1.shape)
print('Shape of label tensor:', labels.shape)

data_1_test = pad_sequences(test_sequences_1, maxlen=MAX_SEQUENCE_LENGTH)
data_2_test = pad_sequences(test_sequences_2, maxlen=MAX_SEQUENCE_LENGTH)
test_ids = np.array(test_ids)


print(data_1.shape)
print(data_2.shape)
print(MAX_SEQUENCE_LENGTH)

########################################
# prepare embeddings
########################################
print('Preparing embedding matrix')

nb_word = min(MAX_NB_WORD, len(word_index)) + 1

embedding_matrix = np.zeros((nb_word, EMBEDDING_DIM))
for word, i in word_index.items():
    if word in word2vec.vocab:
        embedding_matrix[i] = word2vec.word_vec(word)
print('Null word embeddings: %d' %
      np.sum(np.sum(embedding_matrix, axis=1) == 0))

########################################
# sample train/validation data
########################################
# np.random.seed(1234)
perm = np.random.permutation(len(data_1))
idx_train = perm[:int(len(data_1) * (1 - VALIDATION_SPLIT))]
idx_val = perm[int(len(data_1) * (1 - VALIDATION_SPLIT)):]

data_1_train = np.vstack((data_1[idx_train], data_2[idx_train]))
data_2_train = np.vstack((data_2[idx_train], data_1[idx_train]))
labels_train = np.concatenate((labels[idx_train], labels[idx_train]))

data_1_val = np.vstack((data_1[idx_val], data_2[idx_val]))
data_2_val = np.vstack((data_2[idx_val], data_1[idx_val]))
labels_val = np.concatenate((labels[idx_val], labels[idx_val]))

embedding_layer = Embedding(nb_word,
                            EMBEDDING_DIM,
                            weights=[embedding_matrix],
                            input_length=MAX_SEQUENCE_LENGTH,
                            trainable=False)

conv2 = Conv1D(128, 2)
conv3 = Conv1D(128, 3)

lstm1 = Bidirectional(LSTM(NB_LSTM, dropout=RATE_DROP_LSTM,
                           recurrent_dropout=RATE_DROP_LSTM,
                           return_sequences=True))
lstm2 = Bidirectional(LSTM(NB_LSTM, dropout=RATE_DROP_LSTM,
                           recurrent_dropout=RATE_DROP_LSTM))

input1 = Input(shape=(MAX_SEQUENCE_LENGTH,), dtype='int32')
input2 = Input(shape=(MAX_SEQUENCE_LENGTH,), dtype='int32')

x1 = embedding_layer(input1)
x2 = embedding_layer(input2)

if MODEL == 2 or MODEL == 4:
    x1c2 = conv2(x1)
    x1c3 = conv3(x1)
    x1 = concatenate([x1c2, x1c3], axis=1)

    x2c2 = conv2(x2)
    x2c3 = conv3(x2)
    x2 = concatenate([x2c2, x2c3], axis=1)

merged = concatenate([x1, x2])
merged = lstm1(merged)
merged = lstm2(merged)
merged = Dropout(RATE_DROP_DENSE)(merged)
merged = BatchNormalization()(merged)

merged = Dropout(RATE_DROP_DENSE)(merged)
merged = BatchNormalization()(merged)
merged = Dense(NB_DENSE, activation='relu')(merged)

preds = Dense(1, activation='sigmoid')(merged)

model = Model(inputs=[input1, input2], outputs=preds)
model.compile(loss='binary_crossentropy',
              optimizer='nadam',
              metrics=['acc'])
model.summary()

label_information = f'{NB_LSTM}_{NB_DENSE}_{RATE_DROP_LSTM}_{RATE_DROP_DENSE}'
early_stopping = EarlyStopping(monitor='val_loss', patience=3)
model_path = f'model/{label_information}.h5'
model_checkpoint = ModelCheckpoint(model_path,
                                   save_best_only=True,
                                   save_weights_only=True)

print(data_1_train.shape)
print(data_2_train.shape)
print(labels_train.shape)

class_weight = {0: 1.309028344, 1: 0.472001959}
hist = model.fit([data_1_train, data_2_train], labels_train,
                 validation_data=([data_1_val, data_2_val], labels_val),
                 epochs=200, batch_size=2048, shuffle=True,
                 class_weight=class_weight,
                 callbacks=[early_stopping, model_checkpoint])

print(model_path)
model.load_weights(model_path)
bst_val_score = min(hist.history['val_loss'])

if MODEL == 1 or MODEL == 2:
    print('Start making the submission before fine-tuning')
    preds = model.predict([data_1_test, data_2_test],
                          batch_size=512, verbose=1)
    preds += model.predict([data_2_test, data_1_test],
                           batch_size=512, verbose=1)


if MODEL == 3 or MODEL == 4:
    features_model = Model(inputs=[input1, input2], outputs=merged)
    features_model.compile(loss='mse', optimizer='adam')

    X_train = [data_1_train, data_2_train]
    X_val = [data_1_val, data_2_val]
    X_test_1 = [data_1_test, data_2_test]
    X_test_2 = [data_2_test, data_1_test]
    features_train = features_model.predict(X_train, batch_size=2048)
    features_val = features_model.predict(X_val, batch_size=2048)
    features_test_1 = features_model.predict(X_test_1, batch_size=2048)
    features_test_2 = features_model.predict(X_test_2, batch_size=2048)

    y_train = labels_train
    y_val = labels_val

    D_train = xgb.DMatrix(features_train, label=y_train)
    D_val = xgb.DMatrix(features_val, label=y_val)
    D_test_1 = xgb.DMatrix(features_test_1)
    D_test_2 = xgb.DMatrix(features_test_2)

    xgb_params = {
        'objective': 'binary:logistic',
        'booster': 'gbtree',
        'eval_metric': 'logloss',
        'eta': 0.1,
        'max_depth': 9,
        'subsample': 0.9,
        'colsample_bytree': 1 / X_train[0].shape[1]**0.5,
        'min_child_weight': 5,
        'silent': 1
    }

    bst = xgb.train(xgb_params, D_train, 1000,
                    [(D_train, 'train'), (D_val, 'val')],
                    verbose_eval=10, early_stopping_rounds=10)
    preds = bst.predict(D_test_1, ntree_limit=bst.best_ntree_limit)
    preds + bst.predict(D_test_2, ntree_limit=bst.best_ntree_limit)


preds /= 2
submission = pd.DataFrame({'test_id': test_ids, 'is_duplicate': preds.ravel()})

fname = f'result/model{MODEL}_stemming{STEMMING}_stopword{STOPWORD}.csv'
submission.to_csv(fname, index=False)
# submission.to_csv(f'result/model_{MODEL}_{bst_val_score}.csv', index=False)
