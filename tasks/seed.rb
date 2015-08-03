# -*- coding: utf-8 -*-

require 'sqlite3'

system "rm jbisc.db"
db = SQLite3::Database.new('./jbisc.db')

db.execute("CREATE TABLE node(id integer, name text, type text);")
db.execute("CREATE TABLE edge(start integer, end integer);")

query = "INSERT INTO node(id,name,type) VALUES(?,?,?)"

File.foreach('./node.txt') do |line|
  item = line.chomp.split("\|")
  db.execute(query, item[0], item[1], item[2])
end

query = "INSERT INTO edge(start, end) VALUES(?,?)"

File.foreach('./edge.txt') do |line|
  item = line.chomp.split("\|")
  db.execute(query, item[0], item[1])
end
