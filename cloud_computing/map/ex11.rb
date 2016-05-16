#! /usr/bin/ruby

counter = {}

while line = gets
  (time,user,reply,loc,client,hashtags,words) = line.chomp.split("\t")
  hashtags.split.each do |hashtag|
    unless hashtags == "-"
      puts "#{hashtag}\t#{user}"
    end
  end
end
