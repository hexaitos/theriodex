def get_pokemon_moves(pokemon_id, language_id=9)
	return DB.execute("select move_id, name from pokemon_v2_movename where language_id = ? and move_id in (select distinct move_id from pokemon_v2_pokemonmove where pokemon_id = ?);", [language_id, pokemon_id])
end