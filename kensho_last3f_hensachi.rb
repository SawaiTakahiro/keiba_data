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
#勝ち数とか勝率とかまとめて返す
#引数は、順位（数値）が羅列されている配列
#検証したいデータの抽出は別のところでやること
def kensho_rank(list_rank)
	total = list_rank.length
	
	rank1 = list_rank.select{|rank| rank == 1}.length
	rank2 = list_rank.select{|rank| rank == 2}.length
	rank3 = list_rank.select{|rank| rank == 3}.length
	other = list_rank.select{|rank| rank >= 4}.length
	
	shoritsu	= rank1 * 1.0 / total
	rentai		= (rank1 + rank2) * 1.0 / total
	fukusho		= (rank1 + rank2 + rank3) * 1.0 / total
	
	output = Array.new
	output << rank1
	output << rank2
	output << rank3
	output << other
	output << total
	output << shoritsu
	output << rentai
	output << fukusho
	
	return output
end

############################################################


test_comment("データベースを開いて、検証データを読み込むよ")	#テスト用表示
DB = SQLite3::Database.new(LOCALDATA_NAME)	#データベースを開く
query = "select * from view_kensho_last3f_hensachi;"
data = DB.execute(query)

puts data.length

#list_rank = data.map{|raceid, rank, hensachi| rank.to_i}.select{|rank| rank > 0}	#除外されたデータは省いて取得
border = 40
list_rank = data.select{|raceid, rank, hensachi| hensachi.to_f > border && rank.to_i > 0}.map{|raceid, rank, hensachi| rank.to_i}
puts "偏差値#{border}以上", list_rank.length,kensho_rank(list_rank)

border = 60
list_rank = data.select{|raceid, rank, hensachi| hensachi.to_f > border && rank.to_i > 0}.map{|raceid, rank, hensachi| rank.to_i}
puts "偏差値#{border}以上", list_rank.length,kensho_rank(list_rank)

border = 80
list_rank = data.select{|raceid, rank, hensachi| hensachi.to_f > border && rank.to_i > 0}.map{|raceid, rank, hensachi| rank.to_i}
puts "偏差値#{border}以上", list_rank.length,kensho_rank(list_rank)

temp_rank = data.map{|raceid, rank, hensachi| rank.to_i}
temp_hensachi = data.map{|raceid, rank, hensachi| hensachi.to_f}

puts "相関係数", temp_rank.r(temp_hensachi)

test_comment("完了したよ")	#テスト用表示
