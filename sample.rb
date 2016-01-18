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

query = <<SQL
select
	*
from
	N_RACE
limit 10;
SQL

database_name = "source/keiba_data.db"
db = SQLite3::Database.new(database_name)	#データベースを開く

db.transaction do
	p db.execute(query)	#テスト用に表示している
end


