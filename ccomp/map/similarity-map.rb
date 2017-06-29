#!/usr/bin/ruby
query = {"ラーメン" => 1.0}
def cosine(vec1, vec2)
  norm1 = Math.sqrt(vec1.values.map{|v| v ** 2}.inject(:+))
  norm2 = Math.sqrt(vec2.values.map{|v| v ** 2}.inject(:+))
  product = vec1.map{|k,v| v * vec2[k]}.inject(:+)
  return product / (norm1 * norm2)
end
while line = gets
  (key, value) = line.chomp.split("\t")
  vector = Hash.new(0.0)
  value.split(" ").each_slice(2) do |term, element|
    vector[term] = element.to_f
  end
  similarity = cosine(query, vector)
  if similarity > 0.0
    print(key, "\t", similarity, "\n")
  end
end
