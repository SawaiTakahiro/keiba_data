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

#データが馬単位のもの用。initializeがちょっと違う
#ハッシュで足すときのキーが、馬番有りになっている
class Template_keiba_table_umaban < Template_keiba_table
	def initialize(data)
		@data = Hash.new
		
		data.each do |record|
			value = to_hash(record)	#１行分をまとめて値として扱う
			
			key = add_raceid(value["Year"], value["MonthDay"], value["JyoCD"], value["Kaiji"], value["Nichiji"], value["RaceNum"], value["Umaban"])
			
			@data.store(key, value)
		end
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
	
	#レースの条件を出力する
	#場所とか、距離とか。成績の参照に使う
	#そのレースがどんな条件で行われたかだけ抜き出す
	#レースid, 条件のキーなハッシュにして返す
	def get_jouken
		output = Hash.new
		
		@data.each do |key, value|
			
			#そのレースが何だったか。トラックコードで分ける。閾値はjra-vanの方で決めている
			#区分に合わせて、見る馬場コードも変える。障害戦は適当
			track = value["TrackCD"].to_i
			if track < 23 then
				kubun = "t"	#芝
				baba = value["SibaBabaCD"]
			elsif track < 51 then
				kubun = "d"	#ダート
				baba = value["DirtBabaCD"]
			else
				kubun = "s"	#障害
				baba = value["ShibaBabaCD"]
			end
			
			#クラスを見る
			temp = value["JyokenCD5"].to_i
			case temp
			when 1..10 then
				race = 0	#下級条件は0
			when 11..16 then
				race = 1	#1600万下は1
			when 701..703 then
				race = 0	#新馬とか未勝利は下級条件扱いで0
			when 999 then
				race = 1	#オープン以上は1
			else
				race = 0	#よくわからないものは下級条件としておく。とりあえず
			end
			
			#年齢的な条件を見る
			#２歳、３歳限定戦は分ける。それ以外はひとまとめ
			temp = value["SyubetuCD"].to_i
			if temp == 11 || temp == 12 then
				shubetsu = 0	#若駒
			else
				shubetsu = 1	#古馬
			end
			
			
			joken = [value["JyoCD"], kubun, value["Kyori"], race, shubetsu, baba].join("_")
			
			output.store(key, joken)
		end
		
		return output
	end
	
end



#N_HARAI, S_HARAI用クラス
class Table_x_harai < Template_keiba_table
end


#N_UMA_RACE, S_UMA_RACE用クラス	馬ごとレース詳細
class Table_x_uma_race < Template_keiba_table_umaban
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
		temp.store("Wakuban",record[9])
		temp.store("Umaban",record[10])
		temp.store("KettoNum",record[11])
		temp.store("Bamei",record[12])
		temp.store("UmaKigoCD",record[13])
		temp.store("SexCD",record[14])
		temp.store("HinsyuCD",record[15])
		temp.store("KeiroCD",record[16])
		temp.store("Barei",record[17])
		temp.store("TozaiCD",record[18])
		temp.store("ChokyosiCode",record[19])
		temp.store("ChokyosiRyakusyo",record[20])
		temp.store("BanusiCode",record[21])
		temp.store("BanusiName",record[22])
		temp.store("Fukusyoku",record[23])
		temp.store("reserved1",record[24])
		temp.store("Futan",record[25])
		temp.store("FutanBefore",record[26])
		temp.store("Blinker",record[27])
		temp.store("reserved2",record[28])
		temp.store("KisyuCode",record[29])
		temp.store("KisyuCodeBefore",record[30])
		temp.store("KisyuRyakusyo",record[31])
		temp.store("KisyuRyakusyoBefore",record[32])
		temp.store("MinaraiCD",record[33])
		temp.store("MinaraiCDBefore",record[34])
		temp.store("BaTaijyu",record[35])
		temp.store("ZogenFugo",record[36])
		temp.store("ZogenSa",record[37])
		temp.store("IJyoCD",record[38])
		temp.store("NyusenJyuni",record[39])
		temp.store("KakuteiJyuni",record[40])
		temp.store("DochakuKubun",record[41])
		temp.store("DochakuTosu",record[42])
		temp.store("Time",record[43])
		temp.store("ChakusaCD",record[44])
		temp.store("ChakusaCDP",record[45])
		temp.store("ChakusaCDPP",record[46])
		temp.store("Jyuni1c",record[47])
		temp.store("Jyuni2c",record[48])
		temp.store("Jyuni3c",record[49])
		temp.store("Jyuni4c",record[50])
		temp.store("Odds",record[51])
		temp.store("Ninki",record[52])
		temp.store("Honsyokin",record[53])
		temp.store("Fukasyokin",record[54])
		temp.store("reserved3",record[55])
		temp.store("reserved4",record[56])
		temp.store("HaronTimeL4",record[57])
		temp.store("HaronTimeL3",record[58])
		temp.store("KettoNum1",record[59])
		temp.store("Bamei1",record[60])
		temp.store("KettoNum2",record[61])
		temp.store("Bamei2",record[62])
		temp.store("KettoNum3",record[63])
		temp.store("Bamei3",record[64])
		temp.store("TimeDiff",record[65])
		temp.store("RecordUpKubun",record[66])
		temp.store("DMKubun",record[67])
		temp.store("DMTime",record[68])
		temp.store("DMGosaP",record[69])
		temp.store("DMGosaM",record[70])
		temp.store("DMJyuni",record[71])
		temp.store("KyakusituKubun",record[72])
		#########	↑ここまでテーブルごとに書き換える↑	#########
		
		return temp
	end
	
	#上がりタイムを出力する
	def get_last3f
		output = Hash.new
		
		@data.each do |key, value|
			last3f = (value["HaronTimeL3"].to_f * 0.1).round(1)
			output.store(key, last3f)
		end
		
		return output
	end
end
