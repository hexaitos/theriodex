def get_pokemon_ids_by_vg(vg)
	DB.execute(<<-SQL, vg)
	SELECT DISTINCT
		pf.pokemon_id
	FROM pokemon_v2_pokemonform pf
	WHERE
		pf.version_group_id = ?
		and pokemon_id < 1024;
	SQL
end
