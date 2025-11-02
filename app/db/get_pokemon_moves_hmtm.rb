GET_POKEMON_MOVES_HMTM_QSTR = <<-TEXT
SELECT
vg.id AS version_group_id,
vn.name,
machine.machine_number,
name.name,
COALESCE(move_change.type_id, move.type_id) AS type_id,
typename.name,
movedmgname.name,
move.move_damage_class_id,
COALESCE(move_change.power, move.power) AS power,
COALESCE(move_change.accuracy, move.accuracy) AS accuracy,
(movedmgname.move_damage_class_id <> 1 and move.type_id in (select type_id from pokemon_v2_pokemontype where pokemon_id = ?)) as is_stab,
vg.generation_id,
genname.name,
pokemonmove.move_id

FROM pokemon_v2_pokemonmove pokemonmove

JOIN pokemon_v2_move move
	ON move.id = pokemonmove.move_id
JOIN pokemon_v2_movename name
	ON name.move_id = move.id AND name.language_id = ?
JOIN pokemon_v2_movedamageclassname movedmgname
	ON movedmgname.move_damage_class_id = move.move_damage_class_id
	AND movedmgname.language_id = ?
JOIN pokemon_v2_versiongroup vg
	ON vg.id = pokemonmove.version_group_id
JOIN pokemon_v2_generationname genname
	ON genname.generation_id = vg.generation_id
	AND genname.language_id = ?
JOIN pokemon_v2_typename typename
	ON typename.type_id = COALESCE(move_change.type_id, move.type_id)
	AND typename.language_id = ?
JOIN pokemon_v2_machine machine
	ON machine.move_id = pokemonmove.move_id
	AND machine.version_group_id = vg.id
JOIN pokemon_v2_version version
	ON version.version_group_id = machine.version_group_id
JOIN pokemon_v2_versionname vn
	ON vn.version_id = version.id AND vn.language_id = ?
LEFT JOIN pokemon_v2_movechange move_change
	ON move_change.move_id = pokemonmove.move_id
	AND move_change.version_group_id = (
			SELECT MIN(version_group_id)
			FROM pokemon_v2_movechange
			WHERE move_id = pokemonmove.move_id
				AND version_group_id > pokemonmove.version_group_id
	)
WHERE
	pokemonmove.pokemon_id = ?
	AND pokemonmove.move_learn_method_id = 4
	AND vg.generation_id = ?

ORDER BY
	pokemonmove.version_group_id,
	machine.machine_number ASC,
	name.name ASC;
TEXT

GET_POKEMON_MOVES_HMTM_Q = DB.prepare(GET_POKEMON_MOVES_HMTM_QSTR)

def get_pokemon_moves_hmtm(pokemon_id, generation_id, language_id = 9)
	GET_POKEMON_MOVES_HMTM_Q.execute(pokemon_id, language_id, language_id, language_id, language_id, language_id, pokemon_id, generation_id)
end
