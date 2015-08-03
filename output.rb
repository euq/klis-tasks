# -*- encoding: utf-8 -*-

require "sqlite3"

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

# 表示すべきノードの id を指定
id = 1

db = SQLite3::Database.new("./jbisc.db")

db.transaction{
  printnode(id, db)
}

db.close
