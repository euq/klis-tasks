#! /usr/bin/ruby

while line = gets
  (time,user,reply,loc,client,hashtags,words) = line.chomp.split("\t")
  puts "#{time}\t#{user}\t#{reply}\t#{loc}\t#{client}\t#{hashtags}\t#{words}"
end 
