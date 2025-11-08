def get_gens_of_move(move_id)
	DB.execute("select distinct generation_id from pokemon_v2_versiongroup where id in (select version_group_id from pokemon_v2_pokemonmove where move_id = ?)", move_id)
end
