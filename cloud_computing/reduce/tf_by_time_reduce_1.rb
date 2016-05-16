#!/usr/bin/ruby
counts = {}
while line = gets
	(timestamp , word , count) = line.chomp.split("\t")
	counts[timestamp] = {} unless counts[timestamp]
	counts[timestamp][word] = 0 unless counts[timestamp][word]
	counts[timestamp][word] += count.to_i
end

counts.each do |timestamp , hash| hash.each do |word , count|
	puts "#{timestamp}\t#{word}\t#{count}" end
end
