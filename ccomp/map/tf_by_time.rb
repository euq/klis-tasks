#!/usr/bin/ruby
while line = gets
  (time,user,reply,loc,client,hashtags,words) = line.chomp.split("\t")

  timestamp = time.split[1][0..1]
  
  words.split(" ").each do |word|
    puts "#{timestamp}\t#{word}\t1"
  end

end 
