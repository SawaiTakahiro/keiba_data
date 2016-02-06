#! ruby -Ku

=begin
 2016/01/18
 データベースであれこれするためのスクリプト
 
 レースの条件（距離とか）を抜き出してjsonで保存するスクリプト。
 というか、レースのクラスにそういう機能を足したから、呼ぶだけなんだけど…
=end

require "fileutils"
require "CSV"
require "json"

require "sqlite3"
include SQLite3

require "./config.rb"
require "./library.rb"

#ファイルが存在したら、タイムスタンプを返す
def get_time_stamp(path)
	if File.exist?(path) then
		return File.stat(path).mtime
	end
end

path_file_query = "./query/query_read_N_RACE.txt"
query = File.read(path_file_query)

data = nil
#大元のデータベースのオブジェクトには書き込まないので
DB = SQLite3::Database.new(DATABASE_NAME)	#データベースを開く
DB.transaction do
	data = DB.execute(query)	#テスト用に表示している
end

table = Table_x_race.new(data)
list = table.get_jouken

#毎回データベースを読んで保存すると重いので。結果を保存しておく
open("output/list_joken.json", 'w') do |io|
	JSON.dump(list, io)
end
