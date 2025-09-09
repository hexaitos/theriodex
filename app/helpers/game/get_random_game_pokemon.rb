def get_random_game_pokemon(gen=false)
	if !gen or gen == 'any'
		return rand(1..1024)
	else
		pokemon = get_pokemon_ids_by_gen(gen)
		return pokemon[rand(pokemon.size - 1)].first.to_i
	end
end