#! /usr/bin/ruby

counter = {}

while line = gets
  (time,user,reply,loc,client,hashtags,words) = line.chomp.split("\t")
  unless hashtags == "-"
    hashtags.split.each do |hashtag|
      counter[hashtag] = 0 unless counter[hashtag]
      counter[hashtag] += 1
    end
  end
end 

counter.each do |tag, count|
  puts "#{tag}\t#{count}"
end
