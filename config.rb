#! ruby -Ku

=begin
 2016/01/18
 設定まとめ
=end

#読み込みたいデータベース
DATABASE_NAME = "source/keiba_data.db"

#出力先のディレクトリがなかったら作る
path = "output/"
FileUtils.mkdir_p(path) unless FileTest.exist?(path)
