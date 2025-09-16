def get_pokemon_info_by_name(pokemon_name, language_id = 9)
	pokemon_id = DB.get_first_value("select id from pokemon_v2_pokemon where pokemon_species_id in (select pokemon_species_id from pokemon_v2_pokemonspeciesname where lower(name) = lower( ? )) limit 1;", pokemon_name).to_i
	pokemon_data = get_pokemon_info(pokemon_id, language_id)
	pokemon_data
end
