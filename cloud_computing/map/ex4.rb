#! /usr/bin/ruby

# ans: user_tweet_word_count.rb

while line = gets
  (time,user,reply,loc,client,hashtags,words) = line.chomp.split("\t")
  words.split(" ").each do |word|
    print(word, "\t", 1, "\n")
  end
end
