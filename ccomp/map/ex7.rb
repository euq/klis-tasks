#! /usr/bin/ruby

target_hashtag = "#jintai"

counter = {}

while line = gets
  (time,user,reply,loc,client,hashtags,words) = line.chomp.split("\t")
  unless hashtags == "-"
    hashtags.split.each do |hashtag|
      if hashtag == target_hashtag
        puts "#{user}\t1"
      end
    end
  end
end 

