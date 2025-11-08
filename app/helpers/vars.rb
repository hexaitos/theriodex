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

LOCALISED_TEXT = {
	abilities: {
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

	evolutions: {
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

	shiny: {
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

	normal: {
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

	female: {
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

	male: {
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

	toggle_animation: {
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

	damage_taken_from_other_types: {
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

	horizontally_scrollable_on_small_screens: {
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

	direct_link: {
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

	pokemon_with_this_ability: {
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

	hp: {
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

	atk: {
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

	def: {
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

	spatk: {
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

	spdef: {
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

	speed: {
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

	random: {
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

	about: {
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

	search: {
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

	enter_pokemon_name: {
		"en" => "Enter name of a Pokémon / move",
		"de" => "Namen eines Pokémon eingeben",
		"ja" => "ポケモンの名前を入力",
		"ko" => "포켓몬 이름 입력",
		"fr" => "Entrez le nom d’un Pokémon",
		"it" => "Inserisci il nome del Pokémon",
		"es" => "Introduce el nombre de un Pokémon",
		"zh-cn" => "输入宝可梦的名称",
		"zh-tw" => "輸入寶可夢的名稱"
	},

	footer: {
		"en" => "Pokémon and Pokémon character names are trademarks of Nintendo, Game Freak, and Creatures Inc. Theriodex is not affiliated with, authorised, or endorsed by The Pokémon Company, Game Freak, Creatures, or Nintendo.",

		"de" => "„Pokémon“ und die Namen der Pokémon‑Charaktere sind Marken von Nintendo, Game Freak und Creatures Inc. Theriodex ist weder mit The Pokémon Company, Game Freak, Creatures noch mit Nintendo verbunden, oder von diesen autorisiert und wird auch nicht von diesen unterstützt.",

		"ja" => "ポケモンおよびポケモンのキャラクター名は任天堂、Game Freak、およびCreatures Inc.の商標です。Theriodexはポケモンカンパニー、Game Freak、Creatures、任天堂のいずれとも提携しておらず、またそれらの認可や支持を受けていません。",

		"ko" => "포켓몬 및 포켓몬 캐릭터 이름은 닌텐도, Game Freak, Creatures Inc.의 상표입니다。Theriodex는 포켓몬 컴퍼니, Game Freak, Creatures, 닌텐도와 제휴하거나 그들의 승인이나 지원을 받은 바 없습니다。",

		"fr" => "Pokémon et les noms des personnages Pokémon sont des marques de Nintendo, Game Freak et Creatures Inc. Theriodex n'est pas affilié à, autorisé ou soutenu par The Pokémon Company, Game Freak, Creatures ou Nintendo.",

		"it" => "Pokémon e i nomi dei personaggi Pokémon sono marchi di Nintendo, Game Freak e Creatures Inc. Theriodex non è affiliato, autorizzato o supportato da The Pokémon Company, Game Freak, Creatures o Nintendo.",

		"es" => "Pokémon y los nombres de los personajes Pokémon son marcas registradas de Nintendo, Game Freak y Creatures Inc. Theriodex no está afiliado, autorizado ni respaldado por The Pokémon Company, Game Freak, Creatures o Nintendo.",

		"zh-cn" => "“宝可梦”及宝可梦角色名称为任天堂、Game Freak和Creatures Inc.的商标。Theriodex与宝可梦公司、Game Freak、Creatures或任天堂均无关联，亦未获得其授权或支持。",

		"zh-tw" => "「寶可夢」及寶可夢角色名稱為任天堂、Game Freak和Creatures Inc.的商標。Theriodex與寶可夢公司、Game Freak、Creatures或任天堂均無關聯，亦未獲得其授權或支持。"
	},

	game: {
		"en" => "Game",
		"de" => "Spiel",
		"ja" => "ゲーム",
		"ko" => "게임",
		"fr" => "Jeu",
		"it" => "Gioco",
		"es" => "Juego",
		"zh-cn" => "游戏",
		"zh-tw" => "遊戲"
	},

	guess_the_pokemon: {
		"en" => "Guess the Pokémon!",
		"de" => "Errate das Pokémon!",
		"ja" => "ポケモンを当てて！",
		"ko" => "포켓몬을 맞혀보세요!",
		"fr" => "Devinez le Pokémon !",
		"it" => "Indovina il Pokémon!",
		"es" => "¡Adivina el Pokémon!",
		"zh-cn" => "猜宝可梦！",
		"zh-tw" => "猜寶可夢！"
	},

	points: {
		"en" => "Points",
		"de" => "Punkte",
		"ja" => "ポイント",
		"ko" => "점수",
		"fr" => "Points",
		"it" => "Punti",
		"es" => "Puntos",
		"zh-cn" => "分数",
		"zh-tw" => "分數"
	},

	reset: {
		"en" => "Reset",
		"de" => "Zurücksetzen",
		"ja" => "リセット",
		"ko" => "초기화",
		"fr" => "Réinitialiser",
		"it" => "Reimposta",
		"es" => "Reiniciar",
		"zh-cn" => "重置",
		"zh-tw" => "重設"
	},

	enter_pokemon_name_game: {
		"en" => "Enter Pokémon name",
		"de" => "Namen des Pokémon eingeben",
		"ja" => "ポケモン名を入力",
		"ko" => "포켓몬 이름 입력",
		"fr" => "Entrez le nom du Pokémon",
		"it" => "Inserisci il nome del Pokémon",
		"es" => "Introduce el nombre del Pokémon",
		"zh-cn" => "输入宝可梦名称",
		"zh-tw" => "輸入寶可夢名稱"
	},

	guess_button: {
		"en" => "Guess",
		"de" => "Raten",
		"ja" => "予想",
		"ko" => "맞혀보기",
		"fr" => "Deviner",
		"it" => "Indovina",
		"es" => "Adivinar",
		"zh-cn" => "猜",
		"zh-tw" => "猜"
	},

	better_luck_next_time: {
		"en" => "Better luck next time!",
		"de" => "Viel Glück beim nächsten Mal!",
		"ja" => "次は頑張ってね！",
		"ko" => "다음에 더 잘할 거예요!",
		"fr" => "Bonne chance la prochaine fois !",
		"it" => "Meglio la prossima volta!",
		"es" => "¡Mejor suerte la próxima vez!",
		"zh-cn" => "下次再加油！",
		"zh-tw" => "下次再加油！"
	},

	you_guessed_wrong: {
		"en" => "You guessed (name) but the Pokémon was (name)",
		"de" => "Du hast (name) geraten, aber das Pokémon war (name)",
		"ja" => "あなたは「(name)」と入力しましたが、ポケモンは「(name)」でした",
		"ko" => "당신은 (name)라고 추측했지만 포켓몬은 (name)이었어요",
		"fr" => "Vous avez deviné (name), mais le Pokémon était (name)",
		"it" => "Hai indovinato (name), ma il Pokémon era (name)",
		"es" => "Adivinaste (name), pero el Pokémon era (name)",
		"zh-cn" => "你猜的是 (name)，但宝可梦是 (name)",
		"zh-tw" => "你猜的是 (name)，但寶可夢是 (name)"
	},

	play_again: {
		"en" => "Play again!",
		"de" => "Nochmal spielen!",
		"ja" => "もう一度遊ぶ！",
		"ko" => "다시 플레이!",
		"fr" => "Rejouer !",
		"it" => "Gioca di nuovo!",
		"es" => "¡Juega de nuevo!",
		"zh-cn" => "再玩一次！",
		"zh-tw" => "再玩一次！"
	},

	you_guessed_correctly: {
		"en" => "You guessed correctly!",
		"de" => "Du hast richtig geraten!",
		"ja" => "正解です！",
		"ko" => "정답입니다!",
		"fr" => "Bonne réponse !",
		"it" => "Hai indovinato!",
		"es" => "¡Has acertado!",
		"zh-cn" => "你猜对了！",
		"zh-tw" => "你猜對了！"
	},

	well_done: {
		"en" => "You guessed (name) and the Pokémon was (name). Well done!",
		"de" => "Du hast (name) geraten und das Pokémon war (name). Gut gemacht!",
		"ja" => "あなたは「(name)」と答え、ポケモンは「(name)」でした。よくできました！",
		"ko" => "당신은 (name)라고 추측했고 포켓몬은 (name)이었습니다. 잘했어요!",
		"fr" => "Vous avez deviné (name) et le Pokémon était (name). Bien joué !",
		"it" => "Hai indovinato (name) e il Pokémon era (name). Ben fatto!",
		"es" => "Adivinaste (name) y el Pokémon era (name). ¡Bien hecho!",
		"zh-cn" => "你猜的是 (name)，宝可梦是 (name)。做得好！",
		"zh-tw" => "你猜的是 (name)，寶可夢是 (name)。做得好！"
	},

	skip: {
		"en" => "Skip",
		"de" => "Überspringen",
		"ja" => "スキップ",
		"ko" => "건너뛰기",
		"fr" => "Passer",
		"it" => "Salta",
		"es" => "Saltar",
		"zh-cn" => "跳过",
		"zh-tw" => "跳過"
	},

	correct_guesses: {
		"en" => "Correct guesses",
		"de" => "Richtige Antworten",
		"ja" => "正解数",
		"ko" => "정답 수",
		"fr" => "Réponses correctes",
		"it" => "Risposte corrette",
		"es" => "Aciertos",
		"zh-cn" => "猜对次数",
		"zh-tw" => "猜對次數"
	},

	skipped: {
		"en" => "Skipped",
		"de" => "Übersprungen",
		"ja" => "スキップ数",
		"ko" => "건너뛴 수",
		"fr" => "Passés",
		"it" => "Saltati",
		"es" => "Omitidos",
		"zh-cn" => "已跳过",
		"zh-tw" => "已跳過"
	},

	first_letter_of_name: {
		"en" => "First letter of name",
		"de" => "Anfangsbuchstabe",
		"ja" => "名前の頭文字",
		"ko" => "이름의 첫 글자",
		"fr" => "Première lettre du nom",
		"it" => "Prima lettera del nome",
		"es" => "Primera letra del nombre",
		"zh-cn" => "名字的首字母",
		"zh-tw" => "名字的首字母"
	},

	last_letter_of_name: {
		"en" => "Last letter of name",
		"de" => "Letzter Buchstabe",
		"ja" => "名前の最後の文字",
		"ko" => "이름의 마지막 글자",
		"fr" => "Dernière lettre du nom",
		"it" => "Ultima lettera del nome",
		"es" => "Última letra del nombre",
		"zh-cn" => "名字的尾字母",
		"zh-tw" => "名字的尾字母"
	},

	hints: {
		"en" => "Hints",
		"de" => "Tips",
		"ja" => "ヒント",
		"ko" => "힌트",
		"fr" => "Indices",
		"it" => "Indizi",
		"es" => "Pistas",
		"zh-cn" => "提示",
		"zh-tw" => "提示"
	},

	decrease_blur: {
		"en" => "Decrease blur",
		"de" => "Weichzeichnung verringern",
		"ja" => "ぼかしを弱める",
		"ko" => "블러 줄이기",
		"fr" => "Réduire le flou",
		"it" => "Riduci la sfocatura",
		"es" => "Reducir el desenfoque",
		"zh-cn" => "减少模糊",
		"zh-tw" => "減少模糊"
	},

	browse: {
		"en" => "Browse",
		"de" => "Durchsuchen",
		"ja" => "閲覧",
		"ko" => "둘러보기",
		"fr" => "Parcourir",
		"it" => "Sfoglia",
		"es" => "Explorar",
		"zh-cn" => "浏览",
		"zh-tw" => "瀏覽"
	}
}

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
