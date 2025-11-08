GET_ALL_MOVES = <<-SQL
SELECT
    m.id AS move_id,
    m.type_id,
    mn.name,
    MAX(vg.generation_id) AS latest_generation_id
FROM
    pokemon_v2_move m
    JOIN pokemon_v2_movename mn ON mn.move_id = m.id AND mn.language_id = ?
    JOIN pokemon_v2_pokemonmove pm ON pm.move_id = m.id
    JOIN pokemon_v2_versiongroup vg ON pm.version_group_id = vg.id
GROUP BY
    m.id, mn.name
ORDER BY
    m.id;
SQL

GET_ALL_MOVES_Q = DB.prepare(GET_ALL_MOVES)

def get_all_moves(language_id = 9)
	rs = GET_ALL_MOVES_Q.execute(
		language_id
	)

	omega_array = []

	rs.each_hash do |hash|
		omega_array << hash
	end

	omega_array
end
