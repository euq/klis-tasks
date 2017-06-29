#!/usr/bin/ruby

`mkdir output`
`hadoop dfs -getmerge /output/numdocs.txt output/numdocs.txt`
numDocs = File.read("output/numdocs.txt").split("\t")[1].to_f

`hadoop dfs -getmerge /output/term-df.txt output/term-df.txt`
idf = Hash.new(0.0)


File.readlines("output/term-df.txt").each do |line|
  (term,df) = line.chomp.split("\t")
  idf[term] = Math.log(numDocs / df.to_f) + 1.0
end

while line = gets
  (key, terms) = line.chomp.split("\t")
  count = Hash.new(0.0)
  terms.split(" ").each do |term|
    count[term] += idf[term]
  end
  print(key, "\t", count.flatten.join(" "), "\n")
end 
