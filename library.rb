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
class Template_keiba_record
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
		
end


#N_RACE, S_RACE用クラス
class Table_x_race
	class Record_x_race < Template_keiba_record
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
		
		def test
			p @raceid_no_num
		end
		
	end
	
	def initialize(data)
		@data = Hash.new
		
		data.each do |record|
			record = Record_x_race.new(record)
			key = record.raceid_no_num
			
			@data.store(key, record)
		end
	end
	
	def test
		#puts @data
		puts @data.keys
	end
end



#N_HARAI, S_HARAI用クラス
class Table_x_harai
	class Record_x_harai < Template_keiba_record
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
			@TorokuTosu = record[9]
			@SyussoTosu = record[10]
			@FuseirituFlag1 = record[11]
			@FuseirituFlag2 = record[12]
			@FuseirituFlag3 = record[13]
			@FuseirituFlag4 = record[14]
			@FuseirituFlag5 = record[15]
			@FuseirituFlag6 = record[16]
			@FuseirituFlag7 = record[17]
			@FuseirituFlag8 = record[18]
			@FuseirituFlag9 = record[19]
			@TokubaraiFlag1 = record[20]
			@TokubaraiFlag2 = record[21]
			@TokubaraiFlag3 = record[22]
			@TokubaraiFlag4 = record[23]
			@TokubaraiFlag5 = record[24]
			@TokubaraiFlag6 = record[25]
			@TokubaraiFlag7 = record[26]
			@TokubaraiFlag8 = record[27]
			@TokubaraiFlag9 = record[28]
			@HenkanFlag1 = record[29]
			@HenkanFlag2 = record[30]
			@HenkanFlag3 = record[31]
			@HenkanFlag4 = record[32]
			@HenkanFlag5 = record[33]
			@HenkanFlag6 = record[34]
			@HenkanFlag7 = record[35]
			@HenkanFlag8 = record[36]
			@HenkanFlag9 = record[37]
			@HenkanUma1 = record[38]
			@HenkanUma2 = record[39]
			@HenkanUma3 = record[40]
			@HenkanUma4 = record[41]
			@HenkanUma5 = record[42]
			@HenkanUma6 = record[43]
			@HenkanUma7 = record[44]
			@HenkanUma8 = record[45]
			@HenkanUma9 = record[46]
			@HenkanUma10 = record[47]
			@HenkanUma11 = record[48]
			@HenkanUma12 = record[49]
			@HenkanUma13 = record[50]
			@HenkanUma14 = record[51]
			@HenkanUma15 = record[52]
			@HenkanUma16 = record[53]
			@HenkanUma17 = record[54]
			@HenkanUma18 = record[55]
			@HenkanUma19 = record[56]
			@HenkanUma20 = record[57]
			@HenkanUma21 = record[58]
			@HenkanUma22 = record[59]
			@HenkanUma23 = record[60]
			@HenkanUma24 = record[61]
			@HenkanUma25 = record[62]
			@HenkanUma26 = record[63]
			@HenkanUma27 = record[64]
			@HenkanUma28 = record[65]
			@HenkanWaku1 = record[66]
			@HenkanWaku2 = record[67]
			@HenkanWaku3 = record[68]
			@HenkanWaku4 = record[69]
			@HenkanWaku5 = record[70]
			@HenkanWaku6 = record[71]
			@HenkanWaku7 = record[72]
			@HenkanWaku8 = record[73]
			@HenkanDoWaku1 = record[74]
			@HenkanDoWaku2 = record[75]
			@HenkanDoWaku3 = record[76]
			@HenkanDoWaku4 = record[77]
			@HenkanDoWaku5 = record[78]
			@HenkanDoWaku6 = record[79]
			@HenkanDoWaku7 = record[80]
			@HenkanDoWaku8 = record[81]
			@PayTansyoUmaban1 = record[82]
			@PayTansyoPay1 = record[83]
			@PayTansyoNinki1 = record[84]
			@PayTansyoUmaban2 = record[85]
			@PayTansyoPay2 = record[86]
			@PayTansyoNinki2 = record[87]
			@PayTansyoUmaban3 = record[88]
			@PayTansyoPay3 = record[89]
			@PayTansyoNinki3 = record[90]
			@PayFukusyoUmaban1 = record[91]
			@PayFukusyoPay1 = record[92]
			@PayFukusyoNinki1 = record[93]
			@PayFukusyoUmaban2 = record[94]
			@PayFukusyoPay2 = record[95]
			@PayFukusyoNinki2 = record[96]
			@PayFukusyoUmaban3 = record[97]
			@PayFukusyoPay3 = record[98]
			@PayFukusyoNinki3 = record[99]
			@PayFukusyoUmaban4 = record[100]
			@PayFukusyoPay4 = record[101]
			@PayFukusyoNinki4 = record[102]
			@PayFukusyoUmaban5 = record[103]
			@PayFukusyoPay5 = record[104]
			@PayFukusyoNinki5 = record[105]
			@PayWakurenKumi1 = record[106]
			@PayWakurenPay1 = record[107]
			@PayWakurenNinki1 = record[108]
			@PayWakurenKumi2 = record[109]
			@PayWakurenPay2 = record[110]
			@PayWakurenNinki2 = record[111]
			@PayWakurenKumi3 = record[112]
			@PayWakurenPay3 = record[113]
			@PayWakurenNinki3 = record[114]
			@PayUmarenKumi1 = record[115]
			@PayUmarenPay1 = record[116]
			@PayUmarenNinki1 = record[117]
			@PayUmarenKumi2 = record[118]
			@PayUmarenPay2 = record[119]
			@PayUmarenNinki2 = record[120]
			@PayUmarenKumi3 = record[121]
			@PayUmarenPay3 = record[122]
			@PayUmarenNinki3 = record[123]
			@PayWideKumi1 = record[124]
			@PayWidePay1 = record[125]
			@PayWideNinki1 = record[126]
			@PayWideKumi2 = record[127]
			@PayWidePay2 = record[128]
			@PayWideNinki2 = record[129]
			@PayWideKumi3 = record[130]
			@PayWidePay3 = record[131]
			@PayWideNinki3 = record[132]
			@PayWideKumi4 = record[133]
			@PayWidePay4 = record[134]
			@PayWideNinki4 = record[135]
			@PayWideKumi5 = record[136]
			@PayWidePay5 = record[137]
			@PayWideNinki5 = record[138]
			@PayWideKumi6 = record[139]
			@PayWidePay6 = record[140]
			@PayWideNinki6 = record[141]
			@PayWideKumi7 = record[142]
			@PayWidePay7 = record[143]
			@PayWideNinki7 = record[144]
			@PayReserved1Kumi1 = record[145]
			@PayReserved1Pay1 = record[146]
			@PayReserved1Ninki1 = record[147]
			@PayReserved1Kumi2 = record[148]
			@PayReserved1Pay2 = record[149]
			@PayReserved1Ninki2 = record[150]
			@PayReserved1Kumi3 = record[151]
			@PayReserved1Pay3 = record[152]
			@PayReserved1Ninki3 = record[153]
			@PayUmatanKumi1 = record[154]
			@PayUmatanPay1 = record[155]
			@PayUmatanNinki1 = record[156]
			@PayUmatanKumi2 = record[157]
			@PayUmatanPay2 = record[158]
			@PayUmatanNinki2 = record[159]
			@PayUmatanKumi3 = record[160]
			@PayUmatanPay3 = record[161]
			@PayUmatanNinki3 = record[162]
			@PayUmatanKumi4 = record[163]
			@PayUmatanPay4 = record[164]
			@PayUmatanNinki4 = record[165]
			@PayUmatanKumi5 = record[166]
			@PayUmatanPay5 = record[167]
			@PayUmatanNinki5 = record[168]
			@PayUmatanKumi6 = record[169]
			@PayUmatanPay6 = record[170]
			@PayUmatanNinki6 = record[171]
			@PaySanrenpukuKumi1 = record[172]
			@PaySanrenpukuPay1 = record[173]
			@PaySanrenpukuNinki1 = record[174]
			@PaySanrenpukuKumi2 = record[175]
			@PaySanrenpukuPay2 = record[176]
			@PaySanrenpukuNinki2 = record[177]
			@PaySanrenpukuKumi3 = record[178]
			@PaySanrenpukuPay3 = record[179]
			@PaySanrenpukuNinki3 = record[180]
			@PaySanrentanKumi1 = record[181]
			@PaySanrentanPay1 = record[182]
			@PaySanrentanNinki1 = record[183]
			@PaySanrentanKumi2 = record[184]
			@PaySanrentanPay2 = record[185]
			@PaySanrentanNinki2 = record[186]
			@PaySanrentanKumi3 = record[187]
			@PaySanrentanPay3 = record[188]
			@PaySanrentanNinki3 = record[189]
			@PaySanrentanKumi4 = record[190]
			@PaySanrentanPay4 = record[191]
			@PaySanrentanNinki4 = record[192]
			@PaySanrentanKumi5 = record[193]
			@PaySanrentanPay5 = record[194]
			@PaySanrentanNinki5 = record[195]
			@PaySanrentanKumi6 = record[196]
			@PaySanrentanPay6 = record[197]
			@PaySanrentanNinki6 = record[198]
			
			#ここからが自分で足すやつ
			@raceid_no_num = add_raceid_no_num(@Year, @MonthDay, @JyoCD, @Kaiji, @Nichiji, @RaceNum)
			
		end
		
		
		def test
			p @raceid_no_num
		end
		
	end
	
	def initialize(data)
		@data = Hash.new
		
		data.each do |record|
			record = Record_x_harai.new(record)
			key = record.raceid_no_num
			
			@data.store(key, record)
		end
	end
	
	def test
		#puts @data
		#@data[0].test
		puts @data.keys
	end
end
