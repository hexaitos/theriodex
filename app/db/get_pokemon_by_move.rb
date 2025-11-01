def get_pokemon_by_move(move_id, generation_id, language_id = 9)
	DB.results_as_hash = true
	pokemon = DB.execute(<<-SQL, [ language_id, language_id, language_id, language_id, language_id, language_id, generation_id, move_id ])

	SELECT
		pokemonmove.pokemon_id,
		name.name,
		move.type_id,
		typename.name AS type_name,
		move.move_damage_class_id,
		vg.generation_id,
		genname.name AS generation_name,
		pokemonmove.move_id,
		pokemonmove.move_learn_method_id,
		learnmethodname.name AS learn_method_name,
		vn.name AS version_name,
		sprites.sprites,
		vg.name AS version_db,
		gen.name AS gen_db,
		pokemon_species.name AS pokemon_name,
		(SELECT GROUP_CONCAT(type_id, ',')
			 FROM (SELECT type_id
						 FROM pokemon_v2_pokemontype
						 WHERE pokemon_id = pokemonmove.pokemon_id
						 ORDER BY id
						 LIMIT 2)) AS pokemon_type_ids

		FROM pokemon_v2_pokemonmove pokemonmove
		JOIN pokemon_v2_move move
			ON move.id = pokemonmove.move_id
		JOIN pokemon_v2_movelearnmethodname learnmethodname
			ON learnmethodname.move_learn_method_id = pokemonmove.move_learn_method_id
			AND learnmethodname.language_id = ?
		JOIN pokemon_v2_movename name
			ON name.move_id = move.id
			AND name.language_id = ?
		JOIN pokemon_v2_versiongroup vg
			ON vg.id = pokemonmove.version_group_id
		JOIN pokemon_v2_version version
			ON version.version_group_id = vg.id
		JOIN pokemon_v2_versionname vn
			ON vn.version_id = version.id
			AND vn.language_id = ?
		JOIN pokemon_v2_generationname genname
			ON genname.generation_id = vg.generation_id
			AND genname.language_id = ?
		JOIN pokemon_v2_generation gen
			ON gen.id = genname.generation_id
		JOIN pokemon_v2_typename typename
			ON typename.type_id = move.type_id
			AND typename.language_id = ?
		JOIN pokemon_v2_pokemonsprites sprites
			ON sprites.pokemon_id = pokemonmove.pokemon_id
		JOIN pokemon_v2_pokemonspeciesname pokemon_species
			ON pokemon_species.pokemon_species_id = pokemonmove.pokemon_id
			AND pokemon_species.language_id = ?
		JOIN pokemon_v2_pokemontype pokemon_type
			ON pokemon_type.pokemon_id = pokemonmove.pokemon_id
		WHERE
			vg.generation_id = ?
			AND pokemonmove.move_id = ?
			AND pokemonmove.pokemon_id <= 1024
		GROUP BY
			pokemonmove.pokemon_id,
			name.name,
			move.type_id,
			typename.name,
			move.move_damage_class_id,
			vg.generation_id,
			genname.name,
			pokemonmove.move_id,
			pokemonmove.move_learn_method_id,
			learnmethodname.name,
			vn.name,
			sprites.sprites,
			vg.name,
			gen.name,
			pokemon_species.name
		ORDER BY
			vn.name,
			pokemonmove.move_learn_method_id,
			pokemonmove.pokemon_id,
			name.name ASC;
	SQL
	DB.results_as_hash = false

	pokemon
end
