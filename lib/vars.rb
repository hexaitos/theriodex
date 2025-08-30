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

LOCALISED_TEXT = {
	:abilities => {
		"en" => "Abilities",
		"de" => "Fähigkeiten",
		"ja" => "特性",
		"ko" => "특성",
		"fr" => "Talent",
		"it" => "Abilità",
		"zh-CN" => "特性",
		"zh-TW" => "特性"
	},

	:evolutions => {
		"en" => "Evolutions",
		"de" => "Entwicklungen",
		"ja" => "進化",
		"ko" => "진화",
		"fr" => "Évolutions",
		"it" => "Evoluzioni",
		"zh-CN" => "进化",
		"zh-TW" => "進化"
	},

	:shiny => {
		"en" => "Show shiny",
		"de" => "Schillernde Form",
		"ja" => "色違いを表示",
		"ko" => "색이 다른 포켓몬 표시",
		"fr" => "Afficher les chromatiques",
		"it" => "Mostra shiny",
		"zh-CN" => "显示闪光",
		"zh-TW" => "顯示閃光"
	},

	:normal => {
		"en" => "Show normal",
		"de" => "Normale Form",
		"ja" => "通常を表示",
		"ko" => "일반 포켓몬 표시",
		"fr" => "Afficher les normaux",
		"it" => "Mostra normali",
		"zh-CN" => "显示普通",
		"zh-TW" => "顯示普通"
	},

	:female => {
		"en" => "Show female",
		"de" => "Weibliche Form",
		"ja" => "メスを表示",
		"ko" => "암컷 표시",
		"fr" => "Afficher les femelles",
		"it" => "Mostra femmine",
		"zh-CN" => "显示雌性",
		"zh-TW" => "顯示雌性"
	},

	:male => {
		"en" => "Show male",
		"de" => "Männliche Form",
		"ja" => "オスを表示",
		"ko" => "수컷 표시",
		"fr" => "Afficher les mâles",
		"it" => "Mostra maschi",
		"zh-CN" => "显示雄性",
		"zh-TW" => "顯示雄性"
	},

	:toggle_animation => {
		"en" => "Toggle animation",
		"de" => "Animation ein-/ausschalten",
		"ja" => "アニメーション切替",
		"ko" => "애니메이션 전환",
		"fr" => "Basculer l'animation",
		"it" => "Attiva/disattiva animazione",
		"zh-CN" => "切换动画",
		"zh-TW" => "切換動畫"
	},

	:damage_taken_from_other_types => {
		"en" => "Damage taken from other types",
		"de" => "Schaden durch andere Typen",
		"ja" => "他のタイプから受けるダメージ",
		"ko" => "다른 타입으로부터 받는 피해",
		"fr" => "Dégâts reçus des autres types",
		"it" => "Danni subiti da altri tipi",
		"zh-CN" => "来自其他属性的伤害",
		"zh-TW" => "來自其他屬性的傷害"
	},

	:horizontally_scrollable_on_small_screens => {
		"en" => "horizontally scrollable on small screens",
		"de" => "auf kleinen Bildschirmen horizontal scrollbar",
		"ja" => "小さい画面で横にスクロール可能",
		"ko" => "작은 화면에서 가로로 스크롤 가능",
		"fr" => "défilable horizontalement sur les petits écrans",
		"it" => "scorrevole orizzontalmente su schermi piccoli",
		"zh-CN" => "在小屏幕上可横向滚动",
		"zh-TW" => "在小螢幕上可橫向捲動"
	},

	:direct_link => {
		"en" => "direct link",
		"de" => "Direkter Link",
		"ja" => "直接リンク",
		"ko" => "직접 링크",
		"fr" => "Lien direct",
		"it" => "Link diretto",
		"zh-CN" => "直接链接",
		"zh-TW" => "直接連結"
	},

	:pokemon_with_this_ability => {
		"en" => "Pokémon with this ability",
		"de" => "Pokémon mit dieser Fähigkeit",
		"ja" => "この特性を持つポケモン",
		"ko" => "이 특성을 가진 포켓몬",
		"fr" => "Pokémon ayant ce Talent",
		"it" => "Pokémon con questa abilità",
		"zh-CN" => "具有此特性的宝可梦",
		"zh-TW" => "具有此特性的寶可夢"
	}
	}
