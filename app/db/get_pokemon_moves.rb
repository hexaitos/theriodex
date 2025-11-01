def get_pokemon_moves(pokemon_id, language_id = 9)
	moves = DB.execute(<<-SQL, [ pokemon_id, language_id, language_id, language_id, language_id, pokemon_id, pokemon_id ])
		SELECT
			CASE pokemonmove.level
				WHEN 0 THEN 'Evo.'
				ELSE pokemonmove.level
			END AS level,
			name.name,
			move.type_id,
			typename.name,
			movedmgname.name,
			move.move_damage_class_id,
			move.power,
			move.accuracy,
			(movedmgname.move_damage_class_id <> 1 AND move.type_id IN (
				SELECT type_id
				FROM pokemon_v2_pokemontype
				WHERE pokemon_id = ?
			)) AS is_stab,
			vg.generation_id,
			genname.name,
			pokemonmove.move_id
		FROM pokemon_v2_pokemonmove pokemonmove
		JOIN pokemon_v2_move move ON move.id = pokemonmove.move_id
		JOIN pokemon_v2_movename name
			ON name.move_id = move.id
			AND name.language_id = ?
		JOIN pokemon_v2_movedamageclassname movedmgname
			ON movedmgname.move_damage_class_id = move.move_damage_class_id
			AND movedmgname.language_id = ?
		JOIN pokemon_v2_versiongroup vg ON vg.id = pokemonmove.version_group_id
		JOIN pokemon_v2_generationname genname
			ON genname.generation_id = vg.generation_id
			AND genname.language_id = ?
		JOIN pokemon_v2_typename typename
			ON typename.type_id = move.type_id
			AND typename.language_id = ?
		WHERE
			pokemonmove.pokemon_id = ?
			AND pokemonmove.move_learn_method_id = 1
			AND pokemonmove.version_group_id = (
				SELECT MAX(version_group_id)
				FROM pokemon_v2_pokemonmove
				WHERE pokemon_id = ?
			)
		ORDER BY
			pokemonmove.level,
			name.name ASC;
	SQL

	if moves.nil? || moves.empty?
		moves = get_pokemon_moves(pokemon_id, 9)
	end

	moves
end
