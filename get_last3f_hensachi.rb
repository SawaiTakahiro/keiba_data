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

############################################################
#log = Array.new
#log << Time.now	#テスト用	こんな感じにやると、処理時間が振り返れそう

#上がりタイムを出力したファイルを抜き出す
data = CSV.read("./hoge.csv")

#開催が行われた条件だけ抜き出す
list_joken = data.map{|a, b| a}.uniq.sort

#条件ごとにまとめる
subtotal = Hash.new	#集計用

#条件だけ繰り返して、それぞれ見ていく
list_joken.each do |key|
	#キーに合致するものだけ抜き出す
	temp = data.select {|a, b| a == key }
	
	#それの、値の方だけ抜き出して、キーごとに保存
	subtotal[key] = temp.map{|a, b| b}
end

#条件ごとに偏差値を求めてみる
subtotal.each do |key, list|
	stdev = list.standard_deviation
	average = list.avg
	
	#偏差値を求めてみる
	#http://www.suguru.jp/nyuushi/hensachi.html	より
	puts list.map{|value| ((value.to_i - average) * 10 / stdev) + 50}
	
	
	break
end





