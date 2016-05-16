#!/usr/bin/ruby
while line = gets
  (time,user,reply,place,client,hashtags,words) = line.chomp.split("\t")
  if hashtags != "-"
    hashtags.split(" ").each do |hashtag|
      words.split(" ").each do |word|
        print(hashtag, "\t", word, "\n")
      end
    end
  end
end
