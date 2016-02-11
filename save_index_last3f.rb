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

def save_csv_index(filename, data)
	CSV.open(filename, "w") do |csv|
		#むしろ、１行で保存しないと認識してくれないっぽかったので
		#ループを外してそのまま。
		csv << data
	end
end

############################################################
#外部指数の保存フォルダ
save_dir = "output/index_last3f/"
FileUtils.mkdir_p(save_dir) unless FileTest.exist?(save_dir)


#上がりタイムを出力したファイルを抜き出す
DB = SQLite3::Database.new(LOCALDATA_NAME)	#データベースを開く
data = DB.execute("select * from list_last3f_hensachi;")

#レースのリストだけ抜き出す
#これ単位でファイルを保存する
shori_count = 0	#保存したファイルのカウント。けっこう重いので
list_race = data.map{|raceid, value| raceid[0..17]}.uniq
list_race.each_with_index do |raceid_no_num, i|
	#すでに存在していたら飛ばす
	save_filename = save_dir + raceid_no_num + ".csv"
	next if File.exist?(save_filename)
	
	#レース単位で抽出する。値だけ
	temp = Array.new
	temp << raceid_no_num
	temp += data.select{|raceid, value| raceid[0..17] == raceid_no_num}.map{|raceid, value| value}
	save_csv_index(save_filename,temp)
	
	#進捗の表示
	print i, " / ",list_race.length, "\r"
	
	#処理数でリミッターかける場合
	shori_count += 1
	#break if shori_count >= 100
end

p "外部指数の出力が完了しました。"