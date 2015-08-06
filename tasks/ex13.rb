# -*- coding: utf-8 -*-
# ex13

require "sqlite3"

def parse_xpath(xpath)

  # xpathをバックスペース("/")で分割
  # xpathが省略記法で記述されているか、省略されずに記述されているかに関わらず、
  # xpathを分割した配列の1番目と2番目は空になる。
  # そのため、先頭の二つの要素はdropメソッドで消去する
  elems = xpath.gsub(/child\:\:/,'').split('/').drop(2)

  # ベースとなるクエリ
  query = "SELECT n#{(elems.size+1).to_s}.id "
  from  = "FROM node n1 "
  where = "WHERE n1.id = 1 AND n1.name = 'records' "

  # xpathが複数階層であった場合、2階層目以降を処理してクエリを拡張する
  elems.each_with_index do |elem, index|
    from += ", edge e#{(index+1).to_s}, node n#{(index+2).to_s} "
    where += "AND e#{(index+1).to_s}.start = n#{(index+1).to_s}.id 
    AND e#{(index+1).to_s}.end = n#{(index+2).to_s}.id AND n#{(index+2).to_s}.name = '#{elem}' "
  end if elems.size > 0

  # sqlクエリの形に加工する
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

# テストセット

xpath_list = [
  "/records/bibrecord",
  "/records/bibrecord[1]",
  "/records/bibrecord/pub",
  "/records/bibrecord/pub[1]",
  "//bibrecord"
]


# データベースに接続
db = SQLite3::Database.new("./test.db")

xpath_list.each do |xpath|
  index = nil

  # xpathに述語が含まれていた場合
  # 順序の指定を行う事ができるようにする
  if  /\[(\d*)\]$/ =~ xpath
    # 順序指定を取得
    index = xpath.scan(/\[(\d*)\]$/)[0][0].to_i-1
    xpath = xpath.gsub(/\[\d*\]$/, '')
  end
    
  # xpathをパースしてsql文を生成
  query = parse_xpath(xpath)

  # SQL 文を実行
  db.transaction{
    
    # indexが存在する時はindex番目を出力
    # それ以外は検索されたレコードを一件ずつ出力
    if index
      # indexとして指定された順番のレコードのみをprintnodeする
      id = db.execute(query)[index]
      printnode(id, db)
    else
      db.execute(query).each do |row|
        printnode(row[0], db)
      end
    end
  }
end

db.close 
