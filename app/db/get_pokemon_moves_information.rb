def get_pokemon_moves_information(pokemon_id, moves)
	moves_information = []

	moves.each do | move |
		moves_information << DB.execute("select level, version_group_id from pokemon_v2_pokemonmove where move_id = ? and pokemon_id = ?;", move.first, pokemon_id)
	end

	moves_information
end
