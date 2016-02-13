#! ruby -Ku

=begin
 2016/02/13
 データベースであれこれするためのスクリプト
 
 成績を取ってきて書き込む
=end

require "fileutils"
require "CSV"
require "json"

require "sqlite3"
include SQLite3

require "./config.rb"
require "./library.rb"

############################################################

############################################################

test_comment("データベース開くよ")	#テスト用表示
MASTER = SQLite3::Database.new(DATABASE_NAME)	#データベースを開く

test_comment("マスターからデータをとるよ")	#テスト用表示
query = File.read("./query/query_get_seiseki.txt")
data = MASTER.execute(query)

test_comment("データを書き込むよ")	#テスト用表示
DB = SQLite3::Database.new(LOCALDATA_NAME)	#データベースを開く
DB.transaction do
	data.each_with_index do |record, i|
		raceid = record[0]
		rank = record[1]
		
		query = "insert or ignore into list_rank values('#{raceid}', '#{rank}');"
		DB.execute(query)
		
		#進捗の表示用
		print "処理中：", i, " / ", data.length, "\r"
	end
end

test_comment("完了したよ")	#テスト用表示
