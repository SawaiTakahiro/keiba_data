#! ruby -Ku

=begin
 2016/01/18
 データベースであれこれするためのスクリプト
 
 共通の処理とかをまとめたファイル。
=end

#テーブルの構造についての解説は、以下のヘルプページを見る
#EveryDB2概説
#http://cattle.w-wind.net/edb2_manual/

#N_RACE, S_RACE用クラス
class Table_x_race
	class Record_x_race
		def initialize(record)
			@RecordSpec = record[0]
			@DataKubun = record[1]
			@MakeDate = record[2]
			@Year = record[3]
			@MonthDay = record[4]
			@JyoCD = record[5]
			@Kaiji = record[6]
			@Nichiji = record[7]
			@RaceNum = record[8]
			@YoubiCD = record[9]
			@TokuNum = record[10]
			@Hondai = record[11]
			@Fukudai = record[12]
			@Kakko = record[13]
			@HondaiEng = record[14]
			@FukudaiEng = record[15]
			@KakkoEng = record[16]
			@Ryakusyo10 = record[17]
			@Ryakusyo6 = record[18]
			@Ryakusyo3 = record[19]
			@Kubun = record[20]
			@Nkai = record[21]
			@GradeCD = record[22]
			@GradeCDBefore = record[23]
			@SyubetuCD = record[24]
			@KigoCD = record[25]
			@JyuryoCD = record[26]
			@JyokenCD1 = record[27]
			@JyokenCD2 = record[28]
			@JyokenCD3 = record[29]
			@JyokenCD4 = record[30]
			@JyokenCD5 = record[31]
			@JyokenName = record[32]
			@Kyori = record[33]
			@KyoriBefore = record[34]
			@TrackCD = record[35]
			@TrackCDBefore = record[36]
			@CourseKubunCD = record[37]
			@CourseKubunCDBefore = record[38]
			@Honsyokin1 = record[39]
			@Honsyokin2 = record[40]
			@Honsyokin3 = record[41]
			@Honsyokin4 = record[42]
			@Honsyokin5 = record[43]
			@Honsyokin6 = record[44]
			@Honsyokin7 = record[45]
			@HonsyokinBefore1 = record[46]
			@HonsyokinBefore2 = record[47]
			@HonsyokinBefore3 = record[48]
			@HonsyokinBefore4 = record[49]
			@HonsyokinBefore5 = record[50]
			@Fukasyokin1 = record[51]
			@Fukasyokin2 = record[52]
			@Fukasyokin3 = record[53]
			@Fukasyokin4 = record[54]
			@Fukasyokin5 = record[55]
			@FukasyokinBefore1 = record[56]
			@FukasyokinBefore2 = record[57]
			@FukasyokinBefore3 = record[58]
			@HassoTime = record[59]
			@HassoTimeBefore = record[60]
			@TorokuTosu = record[61]
			@SyussoTosu = record[62]
			@NyusenTosu = record[63]
			@TenkoCD = record[64]
			@SibaBabaCD = record[65]
			@DirtBabaCD = record[66]
			@LapTime1 = record[67]
			@LapTime2 = record[68]
			@LapTime3 = record[69]
			@LapTime4 = record[70]
			@LapTime5 = record[71]
			@LapTime6 = record[72]
			@LapTime7 = record[73]
			@LapTime8 = record[74]
			@LapTime9 = record[75]
			@LapTime10 = record[76]
			@LapTime11 = record[77]
			@LapTime12 = record[78]
			@LapTime13 = record[79]
			@LapTime14 = record[80]
			@LapTime15 = record[81]
			@LapTime16 = record[82]
			@LapTime17 = record[83]
			@LapTime18 = record[84]
			@LapTime19 = record[85]
			@LapTime20 = record[86]
			@LapTime21 = record[87]
			@LapTime22 = record[88]
			@LapTime23 = record[89]
			@LapTime24 = record[90]
			@LapTime25 = record[91]
			@SyogaiMileTime = record[92]
			@HaronTimeS3 = record[93]
			@HaronTimeS4 = record[94]
			@HaronTimeL3 = record[95]
			@HaronTimeL4 = record[96]
			@Corner1 = record[97]
			@Syukaisu1 = record[98]
			@Jyuni1 = record[99]
			@Corner2 = record[100]
			@Syukaisu2 = record[101]
			@Jyuni2 = record[102]
			@Corner3 = record[103]
			@Syukaisu3 = record[104]
			@Jyuni3 = record[105]
			@Corner4 = record[106]
			@Syukaisu4 = record[107]
			@Jyuni4 = record[108]
			@RecordUpKubun = record[109]
			@PRIMARY = record[110]
			@JyoCD2 = record[111]
			@Kaiji2 = record[112]
			@Nichiji2 = record[113]
			@RaceNum2 = record[114]
			
			#ここからが自分で足すやつ
			@raceid_no_num = add_raceid_no_num(@Year, @MonthDay, @JyoCD, @Kaiji, @Nichiji, @RaceNum)
		end
		
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
		
		def test
			p @raceid_no_num
		end
		
	end
	
	def initialize(data)
		@data = Array.new
		
		data.each do |record|
			@data << Record_x_race.new(record)
		end
	end
	
	def test
		#puts @data
		@data[0].test
	end
end
