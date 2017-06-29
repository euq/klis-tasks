#!/usr/bin/ruby
currentkey = ""
values = Array.new
while line = gets
  (key, value) = line.chomp.split("\t")
  if key != currentkey
    if values.size > 0
      print(currentkey,"\t",values.join(" "),"\n")
    end
    currentkey = key
    values = Array.new
  end
  values.push(value)
end
if values.size > 0
  print(currentkey,"\t",values.join(" "),"\n")
end
