# -*- coding: utf-8 -*-

require "sqlite3"

def parse_xpath(xpath)
  elems = xpath.gsub(/child\:\:/,'').split('/')
  elems.shift
  query = "SELECT n#{(elems.size).to_s}.id "
  from  = "FROM node n1 "
  where = "WHERE n1.id = 1 AND n1.name = 'records' "
  elems.shift
  elems.each_with_index do |elem, index|
    from += ", edge e#{(index+1).to_s}, node n#{(index+2).to_s} "
    where += "AND e#{(index+1).to_s}.start = n#{(index+1).to_s}.id AND e#{(index+1).to_s}.end = n#{(index+2).to_s}.id AND n#{(index+2).to_s}.name = '#{elem}' "
  end
  query += from + where + ';'
  return query
end

def printnode(id, db)

  current = []
  child = []

  # id で指定されたノードの名前と型 (element/text) を取得
  current = db.execute("select name,type from node where id = ?;", id)

  if current[0][1] == "element"
    printf("<%s>", current[0][0].to_s) # 開始タグの表示

    # 子要素の取得
    child = db.execute("select end from edge where start = ?;", id)

    # 各子要素を再帰的に表示
    child.each {|row|
      printnode(row[0].to_i, db)
    }
    printf("</%s>\n", current[0][0].to_s) #終了タグの表示

  else current[0][1] == "text"
    printf("%s", current[0][0])
  end
end

xpath_list = [
  "/child::books/child::book/child::title",
  "/child::books/child::book",
  "/books/book",
  "/records/bibrecord/pub"
]

db = SQLite3::Database.new("./jbisc.db")

xpath_list.each do |xpath|
  query = parse_xpath(xpath)
  # データベースに接続

  # SQL 文を実行
  db.transaction{
    db.execute(query) {|row|
    # printf("%s\n", row[0])
    printnode(row[0], db)
  }
  }
end

db.close 
