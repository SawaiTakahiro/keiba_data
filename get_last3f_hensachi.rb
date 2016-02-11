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

############################################################
#Arrayクラスのカスタム
#http://unageanu.hatenablog.com/entry/20090312/1236862932	より
class Array
	# 要素をto_iした値の平均を算出する
	def avg
		inject(0.0){|r,i| r+=i.to_i }/size
	end
	# 要素をto_iした値の分散を算出する
	def variance
		a = avg
		inject(0.0){|r,i| r+=(i.to_i-a)**2 }/size
	end
	# 要素をto_iした値の標準偏差を算出する
	def standard_deviation
		Math.sqrt(variance)
	end
end

#コメント表示するだけ
def test_comment(text)
	print Time.now, "	",text, "\n"
end

############################################################
#log = Array.new
#log << Time.now	#テスト用	こんな感じにやると、処理時間が振り返れそう

test_comment("データベース開くよ")	#テスト用表示

#上がりタイムを出力したファイルを抜き出す
#data = CSV.read("./hoge.csv")
#query = "select * from view_last3f_by_joken limit 1000;"
query = File.read("./query/query_get_list_joken.txt")
DB = SQLite3::Database.new(LOCALDATA_NAME)	#データベースを開く
data = DB.execute(query)	#実行するの１個だけなのでそのまま処理してる。複数やるときはトランザクション

test_comment("#{data.length}件、処理するよ")	#テスト用表示
test_comment("条件だけ抜き出すよ")	#テスト用表示
#開催が行われた条件だけ抜き出す
list_joken = data.map{|raceid, joken, last3f| joken}.uniq.sort

test_comment("キーの数繰り返すよ")	#テスト用表示
#条件だけ繰り返して、それぞれ見ていく
subtotal = Hash.new	#集計用
list_joken.each do |key|
	#それの、値の方だけ抜き出して、キーごとに保存
	subtotal[key] = data.select {|raceid, joken, last3f| joken == key }
end

test_comment("偏差値求めるよ")	#テスト用表示
#条件ごとに偏差値を求めてみる
output = Array.new
subtotal.each do |key, list|
	test_comment("#{key}の処理だよ")	#テスト用表示
	
	#集計のためのデータは、（すでに保存済みのデータも含めて）その条件全部から持ってくる
	#条件ごとに取ってきているから重いけど…
	query = "select * from view_last3f_by_joken where joken = '#{key}';"
	all_data = DB.execute(query)	#計算のために持ってくるだけ
	
	temp = all_data.map{|raceid, joken, last3f| last3f.to_i}
	
	stdev = temp.standard_deviation	#標準偏差。集計に使う
	average = temp.avg	#平均。集計に使う
	
	#偏差値を求めてみる
	#http://www.suguru.jp/nyuushi/hensachi.html	より
	#レースid, 値で返してみている。
	output += list.map{|raceid, joken, last3f| [raceid ,((last3f.to_i - average) * 10 / stdev) + 50]}
end

test_comment("データ書き込んでみるよ")	#テスト用表示
#データを書き込んでみるよ
#DB = SQLite3::Database.new(LOCALDATA_NAME)	#データベースを開く→開いてるからそのまま
DB.transaction do
	output.each do |raceid, hensachi|
		hensachi = -1 if hensachi.nan?	#NaNだったら-1とかしとく
		#print raceid, "	", hensachi, "\n"	テスト用表示
		query = "insert into list_last3f_hensachi values('#{raceid}', #{hensachi});"
		DB.execute(query)
	end
end
