class String
	def is_integer?
		self.to_i.to_s == self
	end
end

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
		"es" => "Habilidades",
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
		"es" => "Evoluciones",
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
		"es" => "Mostrar variocolor",
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
		"es" => "Mostrar normal",
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
		"es" => "Mostrar hembra",
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
		"es" => "Mostrar macho",
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
		"es" => "Alternar animación",
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
		"es" => "Daño recibido de otros tipos",
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
		"es" => "desplazable horizontalmente en pantallas pequeñas",
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
		"es" => "Vínculo directo",
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
		"es" => "Pokémon con esta habilidad",
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
		"es" => "PS",
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
		"es" => "Atq",
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
		"es" => "Def",
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
		"es" => "Atq. Esp",
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
		"es" => "Def. Esp",
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
		"es" => "Vel",
		"zh-cn" => "速度",
		"zh-tw" => "速度"
	},

	:random => {
		"en" => "Random",
		"de" => "Zufällig",
		"ja" => "ランダム",
		"ko" => "무작위",
		"fr" => "Aléatoire",
		"it" => "Casuale",
		"es" => "Aleatorio",
		"zh-cn" => "随机",
		"zh-tw" => "隨機"
	},

	:about => {
		"en" => "About",
		"de" => "Über",
		"ja" => "概要",
		"ko" => "소개",
		"fr" => "À propos",
		"it" => "Informazioni",
		"es" => "Acerca de",
		"zh-cn" => "关于",
		"zh-tw" => "關於"
	},

	:search => {
		"en" => "Search",
		"de" => "Suche",
		"ja" => "検索",
		"ko" => "검색",
		"fr" => "Recherche",
		"it" => "Cerca",
		"es" => "Buscar",
		"zh-cn" => "搜索",
		"zh-tw" => "搜尋"
	},

	:enter_pokemon_name => {
		"en" => "Enter name of a Pokémon",
		"de" => "Namen eines Pokémon eingeben",
		"ja" => "ポケモンの名前を入力",
		"ko" => "포켓몬 이름 입력",
		"fr" => "Entrez le nom d’un Pokémon",
		"it" => "Inserisci il nome del Pokémon",
		"es" => "Introduce el nombre de un Pokémon",
		"zh-cn" => "输入宝可梦的名称",
		"zh-tw" => "輸入寶可夢的名稱"
	},

	:footer => {
		"en" => "Made by <a href='https://hexaitos.eu'>Hexaitos</a> with Sinatra (<a href='https://codeberg.org/hexaitos/theriodex'>source code</a>). Pokémon and Pokémon character names are trademarks of Nintendo.",
		"de" => "Erstellt von <a href='https://hexaitos.eu'>Hexaitos</a> mit Sinatra (<a href='https://codeberg.org/hexaitos/theriodex'>Quellcode</a>). „Pokémon“ und die Namen der Pokémon‑Charaktere sind Marken von Nintendo.",
		"ja" => "<a href='https://hexaitos.eu'>Hexaitos</a> が Sinatra を使って作成しました（<a href='https://codeberg.org/hexaitos/theriodex'>ソースコード</a>）。ポケモンおよびポケモンのキャラクター名は任天堂の商標です。",
		"ko" => "<a href='https://hexaitos.eu'>Hexaitos</a>가 Sinatra로 제작했습니다（<a href='https://codeberg.org/hexaitos/theriodex'>소스 코드</a>）。포켓몬 및 포켓몬 캐릭터 이름은 닌텐도의 상표입니다.",
		"fr" => "Créé par <a href='https://hexaitos.eu'>Hexaitos</a> avec Sinatra (<a href='https://codeberg.org/hexaitos/theriodex'>code source</a>). Pokémon et les noms des personnages Pokémon sont des marques de Nintendo.",
		"it" => "Creato da <a href='https://hexaitos.eu'>Hexaitos</a> con Sinatra (<a href='https://codeberg.org/hexaitos/theriodex'>codice sorgente</a>). Pokémon e i nomi dei personaggi Pokémon sono marchi di Nintendo.",
		"es" => "Creado por <a href='https://hexaitos.eu'>Hexaitos</a> con Sinatra (<a href='https://codeberg.org/hexaitos/theriodex'>código fuente</a>). Pokémon y los nombres de los personajes Pokémon son marcas registradas de Nintendo.",
		"zh-cn" => "由 <a href='https://hexaitos.eu'>Hexaitos</a> 使用 Sinatra 制作（<a href='https://codeberg.org/hexaitos/theriodex'>源代码</a>）。“宝可梦”及宝可梦角色名称为任天堂的商标。",
		"zh-tw" => "由 <a href='https://hexaitos.eu'>Hexaitos</a> 使用 Sinatra 製作（<a href='https://codeberg.org/hexaitos/theriodex'>原始程式碼</a>）。「寶可夢」及寶可夢角色名稱為任天堂的商標。"
	}
}