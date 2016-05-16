#! /usr/bin/ruby

# ans: tweet_count.rb

while line = gets
  (time,user,reply,loc,client,hashtags,words) = line.chomp.split("\t")
  print(user, "\t", 1, "\n")
end
