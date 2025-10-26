def get_pokemon_moves(pokemon_id, language_id = 9)
	puts moves = DB.execute("select case pokemonmove.level when 0 then 'Evo.' else pokemonmove.level end as level, name.name, move.type_id, typename.name, movedmgname.name, move.move_damage_class_id, move.power, move.accuracy, (movedmgname.move_damage_class_id <> 1 and move.type_id in (select type_id from pokemon_v2_pokemontype where pokemon_id = ?)) as is_stab, vg.generation_id, genname.name from pokemon_v2_pokemonmove pokemonmove join pokemon_v2_move move on move.id = pokemonmove.move_id join pokemon_v2_movename name on name.move_id = move.id and name.language_id = ? join pokemon_v2_movedamageclassname movedmgname on movedmgname.move_damage_class_id = move.move_damage_class_id and movedmgname.language_id = ? join pokemon_v2_versiongroup vg on vg.id = pokemonmove.version_group_id join pokemon_v2_generationname genname on genname.generation_id = vg.generation_id join pokemon_v2_typename typename on typename.type_id = move.type_id where pokemonmove.pokemon_id = ? and pokemonmove.move_learn_method_id = 1 and genname.language_id = ? and typename.language_id = ? and pokemonmove.version_group_id = (select max(version_group_id) from pokemon_v2_pokemonmove where pokemon_id = ?) order by pokemonmove.level, name.name asc;", [ pokemon_id, language_id, language_id, pokemon_id, language_id, language_id, pokemon_id ])

	if moves.nil? or !moves or moves.size == 0 then
		moves = get_pokemon_moves(pokemon_id, 9)
	end

	moves
end
