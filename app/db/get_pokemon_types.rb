def get_pokemon_types(pokemon_id)
	DB.execute("select type_id from pokemon_v2_pokemontype where pokemon_id = ?", pokemon_id)
end
