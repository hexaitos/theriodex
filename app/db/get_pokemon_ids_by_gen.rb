def get_pokemon_ids_by_gen(gen)
	return DB.execute("select id from pokemon_v2_pokemonspecies where generation_id = ? order by id;", gen)
end