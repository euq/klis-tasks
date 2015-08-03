# -*- coding: utf-8 -*-

require "sqlite3"

xpath = "/child::books/child::book"

# XPath 式に出現する要素名を格納する配列
label = []

# XPath 式を / で分割
steps = xpath.split("/")

# XPath 式を先頭から見ていき，要素名を label[0], label[1], ... に格納
steps.each_with_index do |step,i|
  # steps[0] は空なので読み飛ばす
  next if i == 0

  tmp = step.split("::") # tmp[0] が軸，tmp[1] が要素名
  if tmp[0] != "child"
    STDERR.print i, "番目の軸，おかしいんとちゃいます？\n"
    exit(1)
  end
  label[i-1] = tmp[1]
end

# データベースに投げる SQL 文
sql = "SELECT n2.id
FROM node n1, edge e1, node n2
WHERE n1.id = 1 and n1.name = \"" + label[0] + "\"" +
" and n2.name = \"" + label[1] + "\";"

print sql
=begin
sql = "SELECT n2.id
FROM node n1, edge e1, node n2
WHERE n1.id = 1 and n1.name = \"" + label[0] +
"\" and e1.start = n1.id and e1.end = n2.id
and n2.name = \"" + label[1] + "\";"
=end

# データベースに接続
db = SQLite3::Database.new("./jbisc.db")

# SQL 文を実行
db.transaction{
  db.execute(sql) {|row|
  printf("%s\n", row[0])
}
}

db.close 
