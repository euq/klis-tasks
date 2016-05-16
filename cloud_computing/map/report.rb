#! /usr/bin/ruby

counter = {}

while line = gets
  (time,user,reply,loc,client,hashtags,words) = line.chomp.split("\t")
  puts "#{user}-#{reply}\t1" unless reply == "-"
end
