def search_for_pokemon(query, language_id=9)
	search_results = ""
	query = Sanitize.fragment(query)
	pokemon_names = DB.execute("select name from pokemon_v2_pokemonspeciesname where language_id = ? ", language_id)
	matches = FuzzyMatch.new(pokemon_names, :find_all_with_score => true).find(query)

	matches.each do |key,value|
		# TODO this is all just kinda garbage omg I need to make this not terrible
		pokemon_id = DB.get_first_value("select id from pokemon_v2_pokemon where pokemon_species_id in (select pokemon_species_id from pokemon_v2_pokemonspeciesname where lower(name) = lower( ? )) limit 1;", key.first.to_s).to_s

		pokemon_sprite = JSON.parse(DB.execute("select sprites from pokemon_v2_pokemonsprites where pokemon_id = ?;", pokemon_id).first.first.to_s)["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")

		search_results << "<a href='/show/#{pokemon_id}?lang=#{LANGUAGE_CODES.key(language_id)}'><img src='#{pokemon_sprite}'/><br/>#{format_pokemon_name(key.first.to_s)}<br/></a>" if value >= 0.25
	end

	return search_results
end