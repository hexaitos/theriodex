def get_pokemon_ids_by_type(type)
	DB.execute("select pokemon_id from pokemon_v2_pokemontype where type_id = ? and pokemon_id <= 1024 order by pokemon_id;", type)
end
