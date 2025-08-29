class String
	def is_integer?
		self.to_i.to_s == self
	end
end

DB = SQLite3::Database.new "db.sqlite3"

LANGUAGE_CODES = {
	"ja" => 1,
	"ko"=> 3,
	"zh-cn" => 12,
	"zh-tw" => 4,
	"fr" => 5,
	"de" => 6,
	"es" => 7,
	"it" => 8,
	"en" => 9
}