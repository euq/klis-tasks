#!/usr/bin/ruby
while line = gets
  (key, terms) = line.chomp.split("\t")
  count = Hash.new(0)
  terms.split(" ").each do |term|
    count[term] += 1
  end
  print(key, "\t", count.flatten.join(" "), "\n")
end 
