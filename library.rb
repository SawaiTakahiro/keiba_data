#! ruby -Ku

=begin
 2016/01/18
 データベースであれこれするためのスクリプト
 
 共通の処理とかをまとめたファイル。
=end

#テーブルの構造についての解説は、以下のヘルプページを見る
#EveryDB2概説
#http://cattle.w-wind.net/edb2_manual/

#レースIDとか共通なので

#１行単位のデータのテンプレ
class Template_keiba_table
	attr_reader :raceid_no_num
	
	def add_raceid_no_num(year, monthday, jyocd, kaiji, nichiji, racenum)
		#レースIDの形式
		#西暦4桁、月、日、場所コード、回次、日次、レース番号、（馬番号）
		raceid_no_num = Array.new
		raceid_no_num << "RX"
		raceid_no_num << year
		raceid_no_num << monthday
		raceid_no_num << jyocd
		raceid_no_num << kaiji
		raceid_no_num << nichiji
		raceid_no_num << racenum
		
		return raceid_no_num.join
	end
	
	#馬番ありのほう
	def add_raceid(year, monthday, jyocd, kaiji, nichiji, racenum, umaban)
		#レースIDの形式
		#西暦4桁、月、日、場所コード、回次、日次、レース番号、（馬番号）
		raceid_no_num = Array.new
		raceid_no_num << "RX"
		raceid_no_num << year
		raceid_no_num << monthday
		raceid_no_num << jyocd
		raceid_no_num << kaiji
		raceid_no_num << nichiji
		raceid_no_num << racenum
		raceid_no_num << umaban
		
		return raceid_no_num.join
	end
	
	def initialize(data)
		@data = Hash.new
		
		data.each do |record|
			value = to_hash(record)	#１行分をまとめて値として扱う
			#key = "hoge"
			key = add_raceid_no_num(value["Year"], value["MonthDay"], value["JyoCD"], value["Kaiji"], value["Nichiji"], value["RaceNum"])
			
			@data.store(key, value)
		end
	end
	
	#１行のデータをハッシュにする
	#テーブルごとに上書きして使う
	def to_hash(record)
		temp = Hash.new
		
		#########	↓ここからテーブルごとに書き換える↓	#########
		temp.store("hoge", "fuga")	#ダミー
		#########	↑ここまでテーブルごとに書き換える↑	#########
		
		return temp
	end
	
	def test
		puts @data.keys
	end
end


#N_RACE, S_RACE用クラス
class Table_x_race < Template_keiba_table
	#１行のデータをハッシュにする
	#テーブルごとに上書きして使う
	def to_hash(record)
		temp = Hash.new
		
		#########	↓ここからテーブルごとに書き換える↓	#########
		temp.store("RecordSpec",record[0])
		temp.store("DataKubun",record[1])
		temp.store("MakeDate",record[2])
		temp.store("Year",record[3])
		temp.store("MonthDay",record[4])
		temp.store("JyoCD",record[5])
		temp.store("Kaiji",record[6])
		temp.store("Nichiji",record[7])
		temp.store("RaceNum",record[8])
		temp.store("YoubiCD",record[9])
		temp.store("TokuNum",record[10])
		temp.store("Hondai",record[11])
		temp.store("Fukudai",record[12])
		temp.store("Kakko",record[13])
		temp.store("HondaiEng",record[14])
		temp.store("FukudaiEng",record[15])
		temp.store("KakkoEng",record[16])
		temp.store("Ryakusyo10",record[17])
		temp.store("Ryakusyo6",record[18])
		temp.store("Ryakusyo3",record[19])
		temp.store("Kubun",record[20])
		temp.store("Nkai",record[21])
		temp.store("GradeCD",record[22])
		temp.store("GradeCDBefore",record[23])
		temp.store("SyubetuCD",record[24])
		temp.store("KigoCD",record[25])
		temp.store("JyuryoCD",record[26])
		temp.store("JyokenCD1",record[27])
		temp.store("JyokenCD2",record[28])
		temp.store("JyokenCD3",record[29])
		temp.store("JyokenCD4",record[30])
		temp.store("JyokenCD5",record[31])
		temp.store("JyokenName",record[32])
		temp.store("Kyori",record[33])
		temp.store("KyoriBefore",record[34])
		temp.store("TrackCD",record[35])
		temp.store("TrackCDBefore",record[36])
		temp.store("CourseKubunCD",record[37])
		temp.store("CourseKubunCDBefore",record[38])
		temp.store("Honsyokin1",record[39])
		temp.store("Honsyokin2",record[40])
		temp.store("Honsyokin3",record[41])
		temp.store("Honsyokin4",record[42])
		temp.store("Honsyokin5",record[43])
		temp.store("Honsyokin6",record[44])
		temp.store("Honsyokin7",record[45])
		temp.store("HonsyokinBefore1",record[46])
		temp.store("HonsyokinBefore2",record[47])
		temp.store("HonsyokinBefore3",record[48])
		temp.store("HonsyokinBefore4",record[49])
		temp.store("HonsyokinBefore5",record[50])
		temp.store("Fukasyokin1",record[51])
		temp.store("Fukasyokin2",record[52])
		temp.store("Fukasyokin3",record[53])
		temp.store("Fukasyokin4",record[54])
		temp.store("Fukasyokin5",record[55])
		temp.store("FukasyokinBefore1",record[56])
		temp.store("FukasyokinBefore2",record[57])
		temp.store("FukasyokinBefore3",record[58])
		temp.store("HassoTime",record[59])
		temp.store("HassoTimeBefore",record[60])
		temp.store("TorokuTosu",record[61])
		temp.store("SyussoTosu",record[62])
		temp.store("NyusenTosu",record[63])
		temp.store("TenkoCD",record[64])
		temp.store("SibaBabaCD",record[65])
		temp.store("DirtBabaCD",record[66])
		temp.store("LapTime1",record[67])
		temp.store("LapTime2",record[68])
		temp.store("LapTime3",record[69])
		temp.store("LapTime4",record[70])
		temp.store("LapTime5",record[71])
		temp.store("LapTime6",record[72])
		temp.store("LapTime7",record[73])
		temp.store("LapTime8",record[74])
		temp.store("LapTime9",record[75])
		temp.store("LapTime10",record[76])
		temp.store("LapTime11",record[77])
		temp.store("LapTime12",record[78])
		temp.store("LapTime13",record[79])
		temp.store("LapTime14",record[80])
		temp.store("LapTime15",record[81])
		temp.store("LapTime16",record[82])
		temp.store("LapTime17",record[83])
		temp.store("LapTime18",record[84])
		temp.store("LapTime19",record[85])
		temp.store("LapTime20",record[86])
		temp.store("LapTime21",record[87])
		temp.store("LapTime22",record[88])
		temp.store("LapTime23",record[89])
		temp.store("LapTime24",record[90])
		temp.store("LapTime25",record[91])
		temp.store("SyogaiMileTime",record[92])
		temp.store("HaronTimeS3",record[93])
		temp.store("HaronTimeS4",record[94])
		temp.store("HaronTimeL3",record[95])
		temp.store("HaronTimeL4",record[96])
		temp.store("Corner1",record[97])
		temp.store("Syukaisu1",record[98])
		temp.store("Jyuni1",record[99])
		temp.store("Corner2",record[100])
		temp.store("Syukaisu2",record[101])
		temp.store("Jyuni2",record[102])
		temp.store("Corner3",record[103])
		temp.store("Syukaisu3",record[104])
		temp.store("Jyuni3",record[105])
		temp.store("Corner4",record[106])
		temp.store("Syukaisu4",record[107])
		temp.store("Jyuni4",record[108])
		temp.store("RecordUpKubun",record[109])
		temp.store("PRIMARY",record[110])
		temp.store("JyoCD2",record[111])
		temp.store("Kaiji2",record[112])
		temp.store("Nichiji2",record[113])
		temp.store("RaceNum2",record[114])
		#########	↑ここまでテーブルごとに書き換える↑	#########
		
		return temp
	end
end



#N_HARAI, S_HARAI用クラス
class Table_x_harai < Template_keiba_table
end
