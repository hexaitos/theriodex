def get_random_game_pokemon(gen = false)
	if !gen or gen == "any"
		rand(1..1024)
	else
		pokemon = get_pokemon_ids_by_gen(gen)
		random_pokemon = pokemon[rand(pokemon.size - 1)].first.to_i

		if session[:results] then
			return 134 if session[:results].keys.size + 10 >= pokemon.size
			return get_random_game_pokemon(gen) if session[:results].keys.include?(random_pokemon)
			random_pokemon if !session[:results].keys.include?(random_pokemon)
		else
			random_pokemon
		end
	end
end
