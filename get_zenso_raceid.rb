#! ruby -Ku

=begin
 2016/02/13
 データベースであれこれするためのスクリプト
 
 今回のレースIDと前走のレースIDを取得するスクリプト
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
#上がりタイムを出力したファイルを抜き出す

test_comment("データベース開くよ")	#テスト用表示
MASTER = SQLite3::Database.new(DATABASE_NAME)	#データベースを開く

test_comment("マスターからデータをとるよ")	#テスト用表示
query = File.read("./query/query_get_zenso_raceid.txt")
data = MASTER.execute(query)

test_comment("データの加工をするよ")	#テスト用表示
raceid = data.map{|id, uma| id}
kettonum = data.map{|id, uma| uma}

#適当なデータを入れて、ずらす
temp_raceid = Array.new
temp_raceid << nil
temp_raceid += raceid

#こちらもおなじく、ずらす
temp_kettonum = Array.new
temp_kettonum << nil
temp_kettonum += kettonum

#ずらしたものをひとまとめにする→１レース分ずれたIDがならぶはず
temp = raceid.zip(kettonum, temp_raceid, temp_kettonum)

test_comment("さらに、必要になるraceidだけにするよ")	#テスト用表示
#同じ馬だったものだけ抜き出す→それをさらに、raceid, 前走raceidだけにする
list_zenso = temp.select{|raceid, kettonum, temp_raceid, temp_kettonum| kettonum == temp_kettonum}.map{|raceid, kettonum, temp_raceid, temp_kettonum| [raceid, temp_raceid]}

test_comment("データを書き込むよ")	#テスト用表示
DB = SQLite3::Database.new(LOCALDATA_NAME)	#データベースを開く
DB.transaction do
	list_zenso.each_with_index do |record, i|
		raceid = record[0]
		zenso_raceid = record[1]
		
		query = "insert or ignore into list_zenso_raceid values('#{raceid}', '#{zenso_raceid}');"
		DB.execute(query)
		
		#進捗の表示用
		print "処理中：", i, " / ", list_zenso.length, "\r"
	end
end

test_comment("完了したよ")	#テスト用表示