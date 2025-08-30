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
		"zh-cn" => "特性",
		"zh-tw" => "特性"
	},

	:evolutions => {
		"en" => "Evolutions",
		"de" => "Entwicklungen",
		"ja" => "進化",
		"ko" => "진화",
		"fr" => "Évolutions",
		"it" => "Evoluzioni",
		"zh-cn" => "进化",
		"zh-tw" => "進化"
	},

	:shiny => {
		"en" => "Show shiny",
		"de" => "Schillernde Form",
		"ja" => "色違いを表示",
		"ko" => "색이 다른 포켓몬 표시",
		"fr" => "Afficher les chromatiques",
		"it" => "Mostra shiny",
		"zh-cn" => "显示闪光",
		"zh-tw" => "顯示閃光"
	},

	:normal => {
		"en" => "Show normal",
		"de" => "Normale Form",
		"ja" => "通常を表示",
		"ko" => "일반 포켓몬 표시",
		"fr" => "Afficher les normaux",
		"it" => "Mostra normali",
		"zh-cn" => "显示普通",
		"zh-tw" => "顯示普通"
	},

	:female => {
		"en" => "Show female",
		"de" => "Weibliche Form",
		"ja" => "メスを表示",
		"ko" => "암컷 표시",
		"fr" => "Afficher les femelles",
		"it" => "Mostra femmine",
		"zh-cn" => "显示雌性",
		"zh-tw" => "顯示雌性"
	},

	:male => {
		"en" => "Show male",
		"de" => "Männliche Form",
		"ja" => "オスを表示",
		"ko" => "수컷 표시",
		"fr" => "Afficher les mâles",
		"it" => "Mostra maschi",
		"zh-cn" => "显示雄性",
		"zh-tw" => "顯示雄性"
	},

	:toggle_animation => {
		"en" => "Toggle animation",
		"de" => "Animation ein-/ausschalten",
		"ja" => "アニメーション切替",
		"ko" => "애니메이션 전환",
		"fr" => "Basculer l'animation",
		"it" => "Attiva/disattiva animazione",
		"zh-cn" => "切换动画",
		"zh-tw" => "切換動畫"
	},

	:damage_taken_from_other_types => {
		"en" => "Damage taken from other types",
		"de" => "Schaden durch andere Typen",
		"ja" => "他のタイプから受けるダメージ",
		"ko" => "다른 타입으로부터 받는 피해",
		"fr" => "Dégâts reçus des autres types",
		"it" => "Danni subiti da altri tipi",
		"zh-cn" => "来自其他属性的伤害",
		"zh-tw" => "來自其他屬性的傷害"
	},

	:horizontally_scrollable_on_small_screens => {
		"en" => "horizontally scrollable on small screens",
		"de" => "auf kleinen Bildschirmen horizontal scrollbar",
		"ja" => "小さい画面で横にスクロール可能",
		"ko" => "작은 화면에서 가로로 스크롤 가능",
		"fr" => "défilable horizontalement sur les petits écrans",
		"it" => "scorrevole orizzontalmente su schermi piccoli",
		"zh-cn" => "在小屏幕上可横向滚动",
		"zh-tw" => "在小螢幕上可橫向捲動"
	},

	:direct_link => {
		"en" => "Direct link",
		"de" => "Direkter Link",
		"ja" => "直接リンク",
		"ko" => "직접 링크",
		"fr" => "Lien direct",
		"it" => "Link diretto",
		"zh-cn" => "直接链接",
		"zh-tw" => "直接連結"
	},

	:pokemon_with_this_ability => {
		"en" => "Pokémon with this ability",
		"de" => "Pokémon mit dieser Fähigkeit",
		"ja" => "この特性を持つポケモン",
		"ko" => "이 특성을 가진 포켓몬",
		"fr" => "Pokémon ayant ce Talent",
		"it" => "Pokémon con questa abilità",
		"zh-cn" => "具有此特性的宝可梦",
		"zh-tw" => "具有此特性的寶可夢"
	},

	:hp => {
		"en" => "HP",
		"de" => "KP",
		"ja" => "HP",
		"ko" => "HP",
		"fr" => "PV",
		"it" => "PS",
		"zh-cn" => "HP",
		"zh-tw" => "HP"
	},

	:atk => {
		"en" => "Atk",
		"de" => "Ang",
		"ja" => "攻撃",
		"ko" => "공격",
		"fr" => "Att",
		"it" => "Att",
		"zh-cn" => "攻击",
		"zh-tw" => "攻擊"
	},

	:def => {
		"en" => "Def",
		"de" => "Vert",
		"ja" => "防御",
		"ko" => "방어",
		"fr" => "Déf",
		"it" => "Dif",
		"zh-cn" => "防御",
		"zh-tw" => "防禦"
	},

	:spatk => {
		"en" => "Sp.Atk",
		"de" => "Sp.-Ang",
		"ja" => "特攻",
		"ko" => "특수공격",
		"fr" => "Att. Spé",
		"it" => "Att. Sp",
		"zh-cn" => "特攻",
		"zh-tw" => "特攻"
	},

	:spdef => {
		"en" => "Sp.Def",
		"de" => "Sp.-Vert",
		"ja" => "特防",
		"ko" => "특수방어",
		"fr" => "Déf. Spé",
		"it" => "Dif. Sp",
		"zh-cn" => "特防",
		"zh-tw" => "特防"
	},

	:speed => {
		"en" => "Speed",
		"de" => "Init",
		"ja" => "素早さ",
		"ko" => "스피드",
		"fr" => "Vit",
		"it" => "Vel",
		"zh-cn" => "速度",
		"zh-tw" => "速度"
	}
}
