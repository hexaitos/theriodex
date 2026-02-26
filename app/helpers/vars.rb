class String
	def is_integer?
		self.to_i.to_s == self
	end

	def clean
		Sanitize.fragment(self)
	end
end

$move_cache ||= {}
$pokemon_cache ||= {}

git_sha = `git rev-parse HEAD 2>&1` rescue ""
git_available = $?.success? && git_sha.length >= 6

THERIODEX_VERSION = if git_available
	sha = git_sha[0..5]
	branch = `git rev-parse --abbrev-ref HEAD`.chomp
	date = `git show -s --date=format:%Y%m%d --format=%cd HEAD`.chomp
	"theriodex-#{branch}-#{date}-#{sha}"
	else
	"theriodex-unknown"
end

FONTS = Dir.children("#{Dir.pwd}/public/css/fonts").map { |e| e.gsub(".css", "") }
FONTS.unshift(FONTS.delete("default"))

THEMES = Dir.children("#{Dir.pwd}/public/css/themes").reject { |e| File.basename(e).start_with?(".") }
THEMES.unshift(THEMES.delete("default.css"))

CURSORS = Dir.children("#{Dir.pwd}/public/cursors").reject { |e| File.basename(e).start_with?(".") }

THEME_PASSWORDS = {
	"youdon'tdeserveit" => Float::INFINITY
}

LOCKED_THEMES = {
	"legendary.css" => 10
}

CRIT = {
	0 => {2 => 6.64, 6 => 6.25, 9 => 4.17},
	1 => {9 => 12.5},
	2 => {5 => 25, 9 => 50},
	3 => {2 => 33.2, 5 => 33.3, 9 => 100},
	4 => {5 => 50, 9 => 100}
}

GENS = {
	1 => "generation-i",
	2 => "generation-ii",
	3 => "generation-iii",
	4 => "generation-iv",
	5 => "generation-v",
	6 => "generation-vi",
	7 => "generation-vii",
	8 => "generation-viii",
	9 => "generation-ix",
}

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

CACHE_DIR = "/tmp/cache/rack"

POCKET_SPRITES = {
	1 => "/sprites/items/leaf-stone.png",
	2 => "/sprites/items/potion.png",
	3 => "/sprites/items/beast-ball.png",
	4 => "/sprites/items/tm-ice.png",
	5 => "/sprites/items/berries/colbur-berry.png",
	6 => "/sprites/items/grass-mail.png",
	7 => "/sprites/items/yellow-flute.png",
	8 => "/sprites/items/bicycle.png"
}

GEN_SPRITES = {
	1 => "/sprites/pokemon/1.png",
	2 => "/sprites/pokemon/152.png",
	3 => "/sprites/pokemon/252.png",
	4 => "/sprites/pokemon/387.png",
	5 => "/sprites/pokemon/494.png",
	6 => "/sprites/pokemon/650.png",
	7 => "/sprites/pokemon/722.png",
	8 => "/sprites/pokemon/810.png",
	9 => "/sprites/pokemon/906.png"
}

GEN_RELEASE_YEARS = {
	1 => "1996 - 1998",
	2 => "1999 - 2001",
	3 => "2002 - 2005",
	4 => "2006 - 2009",
	5 => "2010 - 2012",
	6 => "2013 - 2015",
	7 => "2016 - 2018",
	8 => "2019 - 2022",
	9 => "2022"
}
