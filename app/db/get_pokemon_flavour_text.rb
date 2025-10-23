def get_pokemon_flavour_text(pokemon_id, language_id = 9)
	flavour_text = DB.get_first_value("select flavor_text from pokemon_v2_pokemonspeciesflavortext where pokemon_species_id = ? and language_id = ? order by random() limit 1;", [ pokemon_id, language_id ]).to_s.gsub("", " ").gsub("\n", " ").gsub("  ", "")

	flavour_text = get_pokemon_flavour_text(pokemon_id, 9) if flavour_text.nil? or flavour_text.length == 0

	flavour_text
end
