#! ruby -Ku

=begin
 2016/01/18
 データベースであれこれするためのスクリプト
=end

require "fileutils"
require "CSV"
require "json"

require "sqlite3"
include SQLite3

require "./config.rb"
require "./library.rb"


db = SQLite3::Database.new("./source/keiba_data.db")	#原本のデータベースを開く
db.execute('attach "./source/localdata.db" as local')	#コピー先のデータベースをアタッチ

#上がり３Fを抜き出す
path_file_query = "./query/query_add_last3f.txt"
query = File.read(path_file_query)
db.execute(query)

#レースの条件も足しちゃう
path_file_query = "./query/query_add_joken.txt"
query = File.read(path_file_query)
db.execute(query)

#馬ごとレースIDのリストも足しちゃう
path_file_query = "./query/query_add_raceid_by_uma.txt"
query = File.read(path_file_query)
db.execute(query)


db.execute('detach database local')	#コピー先のデータベースを外す！
db.close	#データベースを閉じる



