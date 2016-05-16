#! /usr/bin/ruby

lines = STDIN.readlines

sortedLines = lines.sort_by {|line| -line.split("\t")[2].to_f}

sortedLines.take(1000).each do |line|
  (_, key, value) = line.split("\t")
  print(key, "\t", value)
end
