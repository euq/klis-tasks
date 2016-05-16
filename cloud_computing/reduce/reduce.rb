#! /usr/bin/ruby

# 最終的な集計

currentkey = ""
sum = 0
while line = gets
	(key, value) = line.chomp.split("\t")
	if key != currentkey
		if sum > 0
			print(currentkey, "\t", sum, "\n")
		end
		currentkey = key
		sum = 0
	end
	sum += value.to_i
end
if sum > 0
	print(currentkey, "\t", sum, "\n")
end 
