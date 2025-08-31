def get_pokemon_name(pokemon_id, language_id=9)
	return DB.get_first_value("select name from pokemon_v2_pokemonspeciesname where pokemon_species_id = ? and language_id = ?;", [pokemon_id, language_id]).to_s
end