#!/usr/bin/ruby
require('securerandom')
while line = gets
  (time,user,reply,place,client,hashtags,words) = line.chomp.split("\t")
  if words.split(" ").size > 5
    docid = SecureRandom.uuid.upcase
    print(docid, "\t", words, "\n")
  end
end
