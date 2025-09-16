def get_pokemon_genus(pokemon_id, language_id = 9)
	DB.get_first_value("select genus from pokemon_v2_pokemonspeciesname where language_id = ? and pokemon_species_id = ?;", [ language_id, pokemon_id ]).to_s
end
