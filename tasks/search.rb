# -*- coding: utf-8 -*-

require "sqlite3"

xpath = "/child::books/child::book/child::title"
# xpath = "/child::books/child::book"
# xpath = "/child::books"

def parse_xpath(xpath)
  elems = xpath.gsub(/child\:\:/,'').split('/')
  elems.shift
  query = "SELECT n#{(elems.size).to_s}.id "
  from  = "FROM node n1 "
  where = "WHERE n1.id = 1 AND n1.name = 'books' "
  elems.shift
  elems.each_with_index do |elem, index|
    from += ", edge e#{(index+1).to_s}, node n#{(index+2).to_s} "
    where += "AND e#{(index+1).to_s}.start = n#{(index+1).to_s}.id AND e#{(index+1).to_s}.end = n#{(index+2).to_s}.id AND n#{(index+2).to_s}.name = '#{elem}' "
  end
  query += from + where + ';'
  p query
end

query = parse_xpath(xpath)
# データベースに接続
db = SQLite3::Database.new("./jbisc.db")

# SQL 文を実行
db.transaction{
  db.execute(query) {|row|
  printf("%s\n", row[0])
}
}

db.close 
