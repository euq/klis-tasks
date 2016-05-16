#! /usr/bin/ruby
# -*- coding: utf-8 -*-

noodles = ["うどん", "そば", "パスタ", "ラーメン"]

while line = gets
  key, value = line.split(/\t/)
  if noodles.include?(key)
    print "#{key}\t#{value}"
  end
end
