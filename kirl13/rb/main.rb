# -*- coding. utf-8 -*-
require './cje'

def pre_treatment(file_name)
  ex = CJE.extract(file_name)
  st = CJE.stopword(ex)
  return CJE.stemming(st)
end

def index(sm)
  tf = CJE.tf(sm)
  CJE.idf(tf)
end

def search(sm)
  CJE.retrieval(sm)
end

file_name = ARGV[0]
if file_name == 'documents.txt'
  sm = pre_treatment(file_name)
  index(sm)
elsif file_name == 'query.txt'
  sm = pre_treatment(file_name)
  search(sm)
else
  puts 'usage \'ruby main.rb <FILE>\''
end
