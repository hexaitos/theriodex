def get_pokemon_move_versions(pokemon_id)
	DB.execute("select distinct generation_id from pokemon_v2_versiongroup where id in (select version_group_id from pokemon_v2_pokemonmove where pokemon_id = ?)", pokemon_id)
end
