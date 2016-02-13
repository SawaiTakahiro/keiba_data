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
DB = SQLite3::Database.new(LOCALDATA_NAME)	#データベースを開く
query = File.read("./query/query_get_list_joken.txt")
data = DB.execute(query)	#実行するの１個だけなのでそのまま処理してる。複数やるときはトランザクション


test_comment("#{data.length}件、処理するよ")	#テスト用表示
test_comment("条件だけ抜き出すよ")	#テスト用表示
#開催が行われた条件だけ抜き出す
list_joken = data.map{|raceid, joken, last3f| joken}.uniq.sort


#集計のためのデータは、（すでに保存済みのデータも含めて）その条件全部から持ってくる
#条件ごとに取ってきているから重いけど…　１回だけなら
test_comment("集計用に全データとるよ")	#テスト用表示
all_data = DB.execute("select * from view_last3f_by_joken where last3f < 99.9")	#計算のために持ってくるだけ。書き込むことはない


test_comment("キーの数繰り返して偏差値とるよ")	#テスト用表示
#条件ごとに偏差値を求めてみる
list_hensachi = Array.new
list_joken.each_with_index do |key_joken, i|
	#それの、値の方だけ抜き出して、キーごとに保存
	data_by_joken = data.select {|raceid, joken, last3f| joken == key_joken }
	
	#全データの配列から、必要になる条件を抜き出す
	#それをさらに、last3fだけintで取得してtempに〜とかしている
	temp = all_data.select {|raceid, joken, last3f| joken == key_joken }.map{|raceid, joken, last3f| last3f.to_i}
	
	stdev = temp.standard_deviation	#標準偏差。集計に使う
	average = temp.avg	#平均。集計に使う
	
	#偏差値の求め方　参考にしたサイト
	#http://www.suguru.jp/nyuushi/hensachi.html	より
	#レースid, 値で返してみている。タイムが速い＝値が小さいので逆だった
	
	#raceid, 偏差値で表にする…と思ったら、検索ように馬番無しraceidが必要だった
	list_hensachi += data_by_joken.map{|raceid, joken, last3f| [raceid ,((last3f.to_i - average) * -10 / stdev).round(2) + 50, raceid[0..17]]}
	
	#進捗の表示用
	print "処理中：", i, " / ", list_joken.length, "\r"
end


File.write("hoge.txt", list_hensachi)

test_comment("raceidのリスト取得するよ")	#テスト用表示
#馬番抜きレースIDでリストにする
list_raceid_no_num = list_hensachi.map{|raceid, hensachi, raceid_no_num| raceid_no_num}.uniq


test_comment("データ書き込んでみるよ")	#テスト用表示
#データを書き込んでみるよ
DB.transaction do
	list_raceid_no_num.each_with_index do |key_raceid_no_num, i|
		temp = list_hensachi.select {|raceid, hensachi, raceid_no_num| raceid_no_num == key_raceid_no_num}.map{|raceid, hensachi, raceid_no_num| hensachi}
		text = [key_raceid_no_num, temp].join(",")
		
		#馬番無しレースID, 外部指数として使う用の文字列という形
		#保存する時は、レースIDのほうで好きに分割して、文字列の方をcsvにでもするとよさげ
		query = "insert into list_last3f_hensachi values('#{key_raceid_no_num}', '#{text}');"
		DB.execute(query)
		
		#進捗の表示用
		print "処理中：", i, " / ", list_raceid_no_num.length, "\r"
	end
end

test_comment("処理が終わったよ")	#テスト用表示