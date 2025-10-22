def search_for_pokemon(query, language_id = 9)
	search_results = {}
	language_id == "en" ? language_id = 9 : language_id
	pokemon_names = DB.execute("select name from pokemon_v2_pokemonspeciesname where language_id = ? ", language_id)
	matches = FuzzyMatch.new(pokemon_names, find_all_with_score: true).find(query)

	matches.each do |key, value|
		pokemon_type_names = {}

		pokemon_id = DB.get_first_value("select id from pokemon_v2_pokemon where pokemon_species_id in (select pokemon_species_id from pokemon_v2_pokemonspeciesname where lower(name) = lower( ? )) limit 1;", key.first.to_s).to_i

		pokemon_sprite = JSON.parse(DB.execute("select sprites from pokemon_v2_pokemonsprites where pokemon_id = ?;", pokemon_id).first.first.to_s)["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")

		pokemon_types = get_pokemon_types(pokemon_id)

		pokemon_types.each do | type |
			puts "#{pokemon_id} is #{type}"
			pokemon_type_names[type] = get_pokemon_type_name(type, language_id)
		end

		pokemon_generation = get_pokemon_generation(pokemon_id, language_id)

		if value >= 0.30 then
			search_results[pokemon_id] = {
				name: key.first,
				sprite: pokemon_sprite,
				types: pokemon_type_names,
				gen: pokemon_generation
			}
		end
	end

	search_results
end
