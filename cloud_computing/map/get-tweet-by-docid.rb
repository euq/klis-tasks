#! /usr/bin/ruby
# -*- coding: utf-8 -*-

docid = "0D0D4FE3-B791-492B-B18D-087DBE2BEDAE"

while line = gets
  if line =~ /#{docid}/
    puts line
  end
end
