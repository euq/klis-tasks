#!/usr/bin/ruby

`hadoop dfs -getmerge map/output/sims.txt sims.txt`
scores = Hash.new
File.readlines("sims.txt").each do |line|
  (docid,score) = line.chomp.split("\t")
  scores[docid] = score
end
while line = gets
  (key,value) = line.chomp.split("\t")
  if scores.include?(key)
    print(value, "\t", scores[key], "\n")
  end
end
