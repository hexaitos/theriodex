GET_MOVE_INFORMATION_BY_GEN_QSTR = <<-TEXT
SELECT DISTINCT
		pokemonmove.move_id,
		name.name,
		COALESCE((
				SELECT type_id
				FROM pokemon_v2_movechange
				WHERE move_id = pokemonmove.move_id
					AND version_group_id > pokemonmove.version_group_id
					AND type_id IS NOT NULL
				ORDER BY version_group_id DESC
				LIMIT 1
		), move.type_id) AS move_type_id,
		typename.name AS move_type_name,
		movedmgname.name AS move_damage_name,
		move.move_damage_class_id,
		COALESCE((
				SELECT power
				FROM pokemon_v2_movechange
				WHERE move_id = pokemonmove.move_id
					AND version_group_id > pokemonmove.version_group_id
					AND power IS NOT NULL
				ORDER BY version_group_id DESC
				LIMIT 1
		), move.power) AS move_power,
		COALESCE((
				SELECT accuracy
				FROM pokemon_v2_movechange
				WHERE move_id = pokemonmove.move_id
					AND version_group_id > pokemonmove.version_group_id
					AND accuracy IS NOT NULL
				ORDER BY version_group_id DESC
				LIMIT 1
		), move.accuracy) AS move_accuracy,
		COALESCE((
				SELECT pp
				FROM pokemon_v2_movechange
				WHERE move_id = pokemonmove.move_id
					AND version_group_id > pokemonmove.version_group_id
					AND pp IS NOT NULL
				ORDER BY version_group_id DESC
				LIMIT 1
		), move.pp) AS PP,
		movedmgname.move_damage_class_id AS move_damage_class_id,
		vg.generation_id AS generation_id,
		genname.name AS gen_name,
		vg.id AS version_group_id,
		vn.name AS version_name,
		COALESCE((
				SELECT move_effect_chance
				FROM pokemon_v2_movechange
				WHERE move_id = pokemonmove.move_id
					AND version_group_id > pokemonmove.version_group_id
					AND move_effect_chance IS NOT NULL
				ORDER BY version_group_id DESC
				LIMIT 1
		), move_effect.effect, 'No effect text available') AS move_effect_text,
		COALESCE(move_effect.short_effect, 'No short effect text available') AS move_short_effect_text,
		meta.min_hits,
		meta.max_hits,
		meta.min_turns,
		meta.max_turns,
		meta.crit_rate,
		NULLIF(meta.ailment_chance, 0) as ailment_chance,
		NULLIF(meta.flinch_chance, 0) as flinch_chance,
		NULLIF(meta.stat_chance, 0) as stat_chance,
		meta.move_meta_category_id,
		meta.move_id,
		meta.move_meta_ailment_id,
		meta.drain,
		meta.healing,
		meta_description.description,
		meta_ailment.name AS meta_ailment_name,
		version.id AS version_id,
		version.name as version_db,
		(
				SELECT type_id
				FROM pokemon_v2_movechange
				WHERE move_id = pokemonmove.move_id
					AND version_group_id > pokemonmove.version_group_id
					AND type_id IS NOT NULL
				ORDER BY version_group_id DESC
				LIMIT 1
		) AS type_id_old,
		(
				SELECT power
				FROM pokemon_v2_movechange
				WHERE move_id = pokemonmove.move_id
					AND version_group_id > pokemonmove.version_group_id
					AND power IS NOT NULL
				ORDER BY version_group_id DESC
				LIMIT 1
		) AS power_old,
		(
				SELECT accuracy
				FROM pokemon_v2_movechange
				WHERE move_id = pokemonmove.move_id
					AND version_group_id > pokemonmove.version_group_id
					AND accuracy IS NOT NULL
				ORDER BY version_group_id DESC
				LIMIT 1
		) AS accuracy_old,
		(
				SELECT pp
				FROM pokemon_v2_movechange
				WHERE move_id = pokemonmove.move_id
					AND version_group_id > pokemonmove.version_group_id
					AND pp IS NOT NULL
				ORDER BY version_group_id DESC
				LIMIT 1
		) AS PP_old,
		(
				SELECT move_effect_chance
				FROM pokemon_v2_movechange
				WHERE move_id = pokemonmove.move_id
					AND version_group_id > pokemonmove.version_group_id
					AND move_effect_chance IS NOT NULL
				ORDER BY version_group_id DESC
				LIMIT 1
		) AS effect_chance_old
FROM (
		SELECT DISTINCT move_id, version_group_id
		FROM pokemon_v2_pokemonmove
) AS pokemonmove
JOIN pokemon_v2_move move
		ON move.id = pokemonmove.move_id
JOIN pokemon_v2_movename name
		ON name.move_id = move.id
		AND name.language_id = ?
JOIN pokemon_v2_movedamageclassname movedmgname
		ON movedmgname.move_damage_class_id = move.move_damage_class_id
		AND movedmgname.language_id = ?
JOIN pokemon_v2_versiongroup vg
		ON vg.id = pokemonmove.version_group_id
JOIN pokemon_v2_version version
		ON version.version_group_id = vg.id
JOIN pokemon_v2_generationname genname
		ON genname.generation_id = vg.generation_id
		AND genname.language_id = ?
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
LEFT JOIN pokemon_v2_moveeffecteffecttext move_effect
		ON move_effect.move_effect_id = move.move_effect_id
		AND move_effect.language_id = ?
JOIN pokemon_v2_movemeta meta
		ON meta.move_id = pokemonmove.move_id
JOIN pokemon_v2_movemetacategorydescription meta_description
		ON meta_description.move_meta_category_id = meta.move_meta_category_id
		AND meta_description.language_id = ?
JOIN pokemon_v2_movemetaailmentname meta_ailment
		ON meta_ailment.move_meta_ailment_id = meta.move_meta_ailment_id
		AND meta_ailment.language_id = ?
JOIN pokemon_v2_versionname vn
		ON vn.version_id = version.id
		AND vn.language_id = ?
LEFT JOIN pokemon_v2_movemetastatchange meta_statchange
		ON meta_statchange.move_id = pokemonmove.move_id
LEFT JOIN pokemon_v2_statname meta_statname
		ON meta_statname.stat_id = meta_statchange.stat_id
		AND meta_statname.language_id = ?
WHERE
		pokemonmove.move_id = ?
		AND vg.generation_id = ?
ORDER BY
		pokemonmove.move_id,
		name.name ASC;

TEXT

GET_MOVE_INFORMATION_BY_GEN_Q = DB.prepare(GET_MOVE_INFORMATION_BY_GEN_QSTR)

def get_move_information_by_gen(move_id, generation_id, language_id = 9)
	rs = GET_MOVE_INFORMATION_BY_GEN_Q.execute(language_id, language_id, language_id, language_id, 9, 9, 9, language_id, language_id, move_id, generation_id)

	omega_array = []

	rs.each_hash do | hash |
		omega_array << hash
	end

	omega_array
end
