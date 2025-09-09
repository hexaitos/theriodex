def get_random_game_pokemon(gen=false)
	if !gen or gen == 'any'
		return rand(1..1024)
	else
		pokemon = get_pokemon_ids_by_gen(gen)
		random_pokemon = pokemon[rand(pokemon.size - 1)].first.to_i
		
		if session[:results] then
			return get_random_game_pokemon(gen) if session[:results].keys.include?(random_pokemon)
			return random_pokemon if !session[:results].keys.include?(random_pokemon)
		else
			return random_pokemon
		end
	end
end