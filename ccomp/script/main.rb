# -*- coding: utf-8 -*-

def get_top_n_words(n, data)
  record = {}
  data.each_with_index do |arr, index|
    break if index == n
    record[arr[0]] = arr[1]
  end

  return record
end

n = 5
record = {}

File.foreach("../output/tf_by_time.txt").with_index do |line, index|
  elements = line.split(/\t/)
  record[elements[0]] = {} unless record[elements[0]]
  record[elements[0]][elements[1]] = elements[2].to_i
end


puts '\begin{table}[htb]'
puts "  \\begin{tabular}{|#{Array.new(n+1, "l").join("|")}|} \\hline"
puts "    - & #{[*1..n].join(" & ")} \\\\ \\hline"

record.sort.each do |time, data|
  row = "    #{time}時 & "
  get_top_n_words(n, data.sort{|(_, v1), (_, v2)| v2 <=> v1}).each do |word, count|
    row += "#{word}(#{count}) & "
  end

  print row.sub(/\s\&\s$/, '')
  puts ' \\\\'
end

puts '  \hline '
puts '  \end{tabular}'
puts '\end{table}'
