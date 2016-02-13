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

#csvの機能を使って保存するのはやめた
#csvファイルに、ただのテキストとして書き込んでいくことに
def save_csv_index(filename, data)
	File.open(filename, "w") do |file|
		file << data.join("\n")
	end
end

############################################################
#外部指数の保存フォルダ
save_dir = "output/index_last3f2/"
FileUtils.mkdir_p(save_dir) unless FileTest.exist?(save_dir)


#上がりタイムを出力したファイルを抜き出す
DB = SQLite3::Database.new(LOCALDATA_NAME)	#データベースを開く
data = DB.execute("select * from list_last3f_hensachi;")

#キーを日付に置き換える
data_hiduke = data.map{|raceid_no_num, text| [raceid_no_num[0..9], text]}

#開催の日付単位でファイルの保存をする
shori_count = 0	#保存したファイルのカウント。けっこう重いので進捗表示に使う
list_race = data_hiduke.map{|hiduke, text| hiduke}.uniq
list_race.each_with_index do |key_hiduke, i|
	#すでに存在していたら飛ばす
	save_filename = save_dir + key_hiduke + ".csv"
	#next if File.exist?(save_filename)
	
	#レース単位で抽出する。値だけ
	save_data = data_hiduke.select{|hiduke, text| hiduke == key_hiduke}.map{|hiduke, text| text}
	save_csv_index(save_filename,save_data)
	
	#進捗の表示
	print i, " / ",list_race.length, "\r"
	
	#処理数でリミッターかける場合
	shori_count += 1
	#break if shori_count >= 100
end

p "外部指数の出力が完了しました。"
