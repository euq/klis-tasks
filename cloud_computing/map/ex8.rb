#! /usr/bin/ruby

target_user = "user461285"

counter = {}

while line = gets
  (time,user,reply,loc,client,hashtags,words) = line.chomp.split("\t")
  if target_user == user
    puts words
  end
end 

