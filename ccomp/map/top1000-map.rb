#!/usr/bin/ruby
lines = STDIN.readlines

sortedLines = lines.sort_by {|line| -line.split("\t")[1].to_f}

sortedLines.take(1000).each do |line|
  print("dummy", "\t", line)
end
