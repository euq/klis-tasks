#!/usr/bin/ruby

counts = {}

while line = gets
  (timestamp, word, count) = line.chomp.split("\t")
  counts["#{timestamp}\t#{word}"] = 0 unless counts["#{timestamp}\t#{word}"]
  counts["#{timestamp}\t#{word}"] += count.to_i
end

counts.each do |key, value|
  puts "#{key}\t#{value}"
end
