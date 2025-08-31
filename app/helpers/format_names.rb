def format_pokemon_name(pokemon_name)
	suffixes = {
		"f" => " (f)",
		"m" => " (m)"
	}

	exceptions = {
		"porygon-z" => "Porygon-Z",
		"wo-chien" => "Wo-Chien",
		"chien-pao" => "Chien-Pao",
		"ting-lu" => "Ting-Lu",
		"chi-yu" => "Chi-Yu",
		"gouging-fire" => "Gouging Fire",
		"iron-moth" => "Iron Moth",
		"iron-hands" => "Iron Hands",
		"iron-crown" => "Iron Crown",
		"iron-treads" => "Iron Treads",
		"iron-thorns" => "Iron Thorn",
		"iron-leaves" => "Iron Leaves",
		"iron-bundle" => "Iron Bundle",
		"iron-valiant" => "Iron Valiant",
		"iron-jugulis" => "Iron Jugulis",
		"iron-boulder" => "Iron Boulder",
		"walking-wake" => "Walking Wake",
		"raging-bolt" => "Raging Bolt",
		"great-tusk" => "Great Tusk",
		"scream-tail" => "Scream Tail",
		"brute-bonnet" => "Brute Bonnet",
		"slither-wing" => "Slither Wing",
		"sandy-shocks" => "Sandy Shocks",
		"roaring-moon" => "Roaring Moon",
		"flutter-mane" => "Flutter Mane",
		"kommo-o" => "Kommo-o",
		"hakamo-o" => "Hakamo-o",
		"jangmo-o" => "Jangmo-o"
	}

	formatted_name = ""

	pokemon_name_base, *pokemon_name_suffixes = pokemon_name.split("-").map(&:capitalize)

	pokemon_name_suffixes.size == 0 ? formatted_name = pokemon_name_base : formatted_name = "#{pokemon_name_base} (#{pokemon_name_suffixes.join(' ')})"

	suffixes.each do |suffix, formatted|
		if pokemon_name.sub(/^[^-]*-/, '') == suffix then
			formatted_name = pokemon_name.capitalize.gsub("-#{suffix}", '') + formatted
		end
	end

	exceptions.each do |exception, formatted|
		if pokemon_name == exception then
			formatted_name = formatted
		end
	end

	return formatted_name
end