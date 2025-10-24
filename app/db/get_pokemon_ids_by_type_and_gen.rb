def get_pokemon_ids_by_gen_and_type(gen, type)
	DB.execute("select pokemon_id from pokemon_v2_pokemontype where pokemon_id in (select id from pokemon_v2_pokemonspecies where generation_id = ? order by id) and type_id = ? and pokemon_id <= 1024 order by pokemon_id;", [ gen, type ])
end
