def get_pokemon_moves_by_gen(pokemon_id, generation_id, language_id = 9)
	DB.execute(<<-SQL, [ pokemon_id, language_id, language_id, pokemon_id, language_id, language_id, generation_id ])
	SELECT DISTINCT
	CASE pokemonmove.level
		WHEN 0 THEN 'evo.'
		ELSE pokemonmove.level
	END AS level,
	name.name,
	COALESCE((
		SELECT type_id
		FROM pokemon_v2_movechange
		WHERE move_id = pokemonmove.move_id
		  AND version_group_id > pokemonmove.version_group_id
		  AND type_id IS NOT NULL
		ORDER BY version_group_id DESC
		LIMIT 1
	), move.type_id) AS type_id,
	typename.name,
	movedmgname.name,
	move.move_damage_class_id,
	COALESCE((
		SELECT power
		FROM pokemon_v2_movechange
		WHERE move_id = pokemonmove.move_id
		  AND version_group_id > pokemonmove.version_group_id
		  AND power IS NOT NULL
		ORDER BY version_group_id DESC
		LIMIT 1
	), move.power) AS power,
	COALESCE((
		SELECT accuracy
		FROM pokemon_v2_movechange
		WHERE move_id = pokemonmove.move_id
		  AND version_group_id > pokemonmove.version_group_id
		  AND accuracy IS NOT NULL
		ORDER BY version_group_id DESC
		LIMIT 1
	), move.accuracy) AS accuracy,
	(movedmgname.move_damage_class_id <> 1 AND (
		COALESCE((
			SELECT type_id
			FROM pokemon_v2_movechange
			WHERE move_id = pokemonmove.move_id
			  AND version_group_id > pokemonmove.version_group_id
			  AND type_id IS NOT NULL
			ORDER BY version_group_id DESC
			LIMIT 1
		), move.type_id)
	) IN (
		SELECT type_id
		FROM pokemon_v2_pokemontype
		WHERE pokemon_id = ?
	)) AS is_stab,
	vg.generation_id,
	genname.name,
	pokemonmove.move_id,
	gen_db.name as gen_db_name,
	sprites.sprites as sprites
FROM pokemon_v2_pokemonmove pokemonmove
JOIN pokemon_v2_move move
	ON move.id = pokemonmove.move_id
JOIN pokemon_v2_pokemonsprites sprites
	ON sprites.pokemon_id = pokemonmove.pokemon_id
JOIN pokemon_v2_movename name
	ON name.move_id = move.id
	AND name.language_id = ?
JOIN pokemon_v2_movedamageclassname movedmgname
	ON movedmgname.move_damage_class_id = move.move_damage_class_id
	AND movedmgname.language_id = ?
JOIN pokemon_v2_versiongroup vg
	ON vg.id = pokemonmove.version_group_id
JOIN pokemon_v2_generationname genname
	ON genname.generation_id = vg.generation_id
JOIN pokemon_v2_generation gen_db
	ON gen_db.id = genname.generation_id
JOIN pokemon_v2_typename typename
	ON typename.type_id = COALESCE((
			SELECT type_id
			FROM pokemon_v2_movechange
			WHERE move_id = pokemonmove.move_id
			  AND version_group_id > pokemonmove.version_group_id
			  AND type_id IS NOT NULL
			ORDER BY version_group_id DESC
			LIMIT 1
		), move.type_id)
WHERE
	pokemonmove.pokemon_id = ?
	AND pokemonmove.move_learn_method_id = 1
	AND genname.language_id = ?
	AND typename.language_id = ?
	AND vg.generation_id = ?
ORDER BY
	pokemonmove.level,
	name.name ASC;

	SQL
end
