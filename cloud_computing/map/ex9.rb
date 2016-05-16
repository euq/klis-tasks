#! /usr/bin/ruby

counter = {}

while line = gets
  (time,user,reply,loc,client,hashtags,words) = line.chomp.split("\t")
  puts "#{time.split[1].split(":")[0]}\t1"
end 

