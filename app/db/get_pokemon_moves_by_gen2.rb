GET_POKEMON_MOVES_BY_GEN_VERSIONED_QSTR = <<-TEXT
SELECT DISTINCT
	CASE pokemonmove.level
		WHEN 0 THEN 'evo.'
		ELSE pokemonmove.level
	END AS level,
	name.name as move_name,
	COALESCE((
		SELECT type_id
		FROM pokemon_v2_movechange
		WHERE move_id = pokemonmove.move_id
		  AND version_group_id > pokemonmove.version_group_id
		  AND type_id IS NOT NULL
		ORDER BY version_group_id DESC
		LIMIT 1
	), move.type_id) AS type_id,
	typename.name as type_name,
	movedmgname.name as cat,
	move.move_damage_class_id as cat_id,
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
	genname.name as gen_name,
	pokemonmove.move_id,
	gen_db.name as gen_db_name,
	vn.name as version_name
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
JOIN pokemon_v2_version version
	ON version.version_group_id = pokemonmove.version_group_id
JOIN pokemon_v2_versionname vn
	ON vn.version_id = version.id
	AND vn.language_id = ?
JOIN pokemon_v2_generationname genname
	ON genname.generation_id = vg.generation_id
	AND genname.language_id = ?
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
	AND typename.language_id = ?
WHERE
	pokemonmove.pokemon_id = ?
	AND pokemonmove.move_learn_method_id = ?
	AND vg.generation_id = ?
ORDER BY
	pokemonmove.level,
	name.name ASC;
TEXT

GET_POKEMON_MOVES_BY_GEN_VERSIONED_Q = DB.prepare(GET_POKEMON_MOVES_BY_GEN_VERSIONED_QSTR)

def get_pokemon_moves_by_gen2(pokemon_id, generation_id, language_id = 9)
	rs = GET_POKEMON_MOVES_BY_GEN_VERSIONED_Q.execute(
		pokemon_id,
		language_id,
		language_id,
		language_id,
		language_id,
		language_id,
		pokemon_id,
		1,
		generation_id
	)

	omega_array = []

	rs.each_hash do |hash|
		omega_array << hash
	end

	omega_array
end
