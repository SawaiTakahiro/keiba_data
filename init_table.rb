#! ruby -Ku

=begin
 2016/02/09
 データベースであれこれするためのスクリプト
 
 テーブルの初期化をするやつ。
 テーブルがないとinsertとかできないので。
 ローカルのデータベースに、テーブルを作って打っ込む。
=end

require "fileutils"
require "CSV"
require "json"

require "sqlite3"
include SQLite3

require "./config.rb"
require "./library.rb"

##################################################
#テーブルの初期化
#必要になるテーブル作成のクエリをどんどん足していく
list_query = Array.new
list_query << "create table if not exists list_last3f(raceid primary key, last3f);"
list_query << "create table if not exists list_joken(raceid_no_num primary key, joken);"

list_query << File.read("./query/query_create_view_list_joken.txt")


##################################################
#ここから、データベースに足す処理
db = SQLite3::Database.new("./source/localdata.db")	#ローカルのデータベースにテーブルを足すよ！

#リストにあるだけ、テーブルを作っちゃう
list_query.each do |query|
	db.execute(query)
end

db.close	#データベースを閉じる
##################################################
