#!/usr/bin/ruby
while line = gets
  (_,terms) = line.chomp.split("\t")
  terms.split(" ").uniq.each do |term|
    print(term, "\t", 1, "\n")
  end
end 
