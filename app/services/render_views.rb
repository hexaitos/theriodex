def pokemon_view_moves(pokemon_id, gen_id, language_id = 9)
	id = Sanitize.fragment(pokemon_id)
	language_id == "en" ? language_id = 9 : language_id
	puts pokemon_id

	{
		id: id,
		moves: get_pokemon_moves_by_gen(pokemon_id, gen_id, language_id),
		gens: get_pokemon_move_versions(pokemon_id).flatten,
		name: get_pokemon_name(pokemon_id, language_id),
		lang: language_id
	}
end

def pokemon_view_search(query, language_id = 9)
	query = Sanitize.fragment(query)
	{
		search_results: search_for_pokemon(query, language_id),
		lang: LANGUAGE_CODES.key(language_id)
	}
end

def pokemon_view_game(id, language_id = 9, difficulty = "easy")
	selected_pokemon = Sanitize.fragment(id)
	language_id == "en" ? language_id = 9 : language_id
	session[:pokemon_info] = game_data = get_game_info(id, language_id, difficulty)
	game_data[:points] = session[:points] ||= 0
	game_data[:guesses] = session[:guesses] ||= 0
	game_data[:skips] = session[:skips] ||= 0
	game_data[:results] = session[:results] ||= {}

	puts "(#{Time.now.strftime('%d.%m-%Y %H:%M')}) - Game data: #{game_data}\n\n"

	game_data
end

def pokemon_view_results
	raise Sinatra::NotFound if !session[:results]

	game_data = session[:pokemon_info]
	game_data[:points] = session[:points]
	game_data[:guesses] = session[:guesses]
	game_data[:skips] = session[:skips]
	game_data[:results] = session[:results]

	game_data
end

def pokemon_view_guess
end

def pokemon_view_ability(id, language_id = 9)
	id = Sanitize.fragment(id)
	pokemon_with_ability_raw = get_pokemons_with_ability(id)
	pokemon_with_ability = {}
	language_id == "en" ? language_id = 9 : language_id

	ability_name = get_pokemon_ability_name(id)
	raise Sinatra::NotFound if ability_name.nil?

	pokemon_with_ability_raw.each do | pokemon |
		pokemon_with_ability[pokemon.first] = {}
		pokemon_with_ability[pokemon.first][:name] = get_pokemon_name(pokemon.first, language_id)
		pokemon_with_ability[pokemon.first][:sprite] = get_pokemon_sprites(pokemon.first)[:front_sprite]
		pokemon_with_ability[pokemon.first][:types] = get_pokemon_types(pokemon)
		pokemon_with_ability[pokemon.first][:gen] = get_pokemon_generation(pokemon, language_id)
	end

	{
		ability_information: get_pokemon_ability_information(id, language_id),
		pokemon_with_ability: pokemon_with_ability,
		ability_name: get_pokemon_ability_name(id, language_id),
		id: id,
		lang: LANGUAGE_CODES.key(language_id)
	}
end

def pokemon_view_gen(gen, language_id = 9)
	gen = Sanitize.fragment(gen)
	pokemon_of_gen_raw = get_pokemon_ids_by_gen(gen)
	raise Sinatra::NotFound if pokemon_of_gen_raw.size == 0

	pokemon_of_gen = {}
	generation = nil
	language_id == "en" ? language_id = 9 : language_id
	versions = get_versions_from_gen(gen, language_id).flatten.join(' • ')

	pokemon_of_gen_raw.each do | pokemon |
		generation ||= get_pokemon_generation(pokemon.first, language_id)
		pokemon_of_gen[pokemon.first] = {}
		pokemon_of_gen[pokemon.first][:name] = get_pokemon_name(pokemon.first, language_id)
		pokemon_of_gen[pokemon.first][:sprite] = get_pokemon_sprites(pokemon.first)[:front_sprite]
		pokemon_of_gen[pokemon.first][:types] = get_pokemon_types(pokemon)
		pokemon_of_gen[pokemon.first][:gen] = get_pokemon_generation(pokemon, language_id)
	end

	{
		pokemon_of_gen: pokemon_of_gen,
		versions: versions,
		years: GEN_RELEASE_YEARS[gen.to_i],
		lang: LANGUAGE_CODES.key(language_id),
		gen: generation
	}
end

def pokemon_view_type(type, language_id = 9, gen = nil)
	type = Sanitize.fragment(type)
	type_name ||= get_pokemon_type_name(type, language_id)
	efficacy_weakness ||= get_efficacy_weakness(type)

	if gen.nil?
		pokemon_of_type_raw = get_pokemon_ids_by_type(type)
	else
		pokemon_of_type_raw = get_pokemon_ids_by_gen_and_type(gen, type)
	end
	raise Sinatra::NotFound if pokemon_of_type_raw.size == 0

	pokemon_of_type = {}
	language_id == "en" ? language_id = 9 : language_id

	pokemon_of_type_raw.each do | pokemon |
		pokemon_of_type[pokemon.first] = {}
		pokemon_of_type[pokemon.first][:name] = get_pokemon_name(pokemon.first, language_id)
		pokemon_of_type[pokemon.first][:sprite] = get_pokemon_sprites(pokemon.first)[:front_sprite]
		pokemon_of_type[pokemon.first][:types] = get_pokemon_types(pokemon)
		pokemon_of_type[pokemon.first][:gen] = get_pokemon_generation(pokemon.first, language_id)
	end

	{
		type_num: type,
		type_name: type_name,
		efficacy_weakness: efficacy_weakness,
		num_of_pokemon: pokemon_of_type.count,
		pokemon_of_type: pokemon_of_type,
		lang: LANGUAGE_CODES.key(language_id)
	}
end

def pokemon_view_index(id, form = nil, s = nil, animated = false, language_id = 9)
	selected_pokemon = Sanitize.fragment(id)
	selected_sex = Sanitize.fragment(s)
	animated = Sanitize.fragment(animated) unless !animated
	language_id == "en" ? language_id = 9 : language_id

	# I only just learnt about these things called ternary operators? So of course I am going to try using them now even though I could have also just have written an if statement
	form.nil? ? selected_form = nil : selected_form = Sanitize.fragment(form)
	s.nil? ? selected_sex = nil : selected_sex = Sanitize.fragment(s)

	begin
		selected_pokemon.is_integer? ? pokemon_data = get_pokemon_info(selected_pokemon, language_id) : pokemon_data = get_pokemon_info_by_name(selected_pokemon, language_id)
	rescue JSON::ParserError
		raise Sinatra::NotFound
	end

	puts "(#{Time.now.strftime('%d.%m-%Y %H:%M')}) - The following Pokémon was selected: #{selected_pokemon}.\n The following data was returned: #{pokemon_data}\n\n"

	pokemon_data[:id] = selected_pokemon
	pokemon_data[:damage_taken] = damage_taken(pokemon_data[:types])
	pokemon_data[:form] = selected_form
	pokemon_data[:sex] = selected_sex
	pokemon_data[:animated] = animated
	pokemon_data[:move_gens] = get_pokemon_move_versions(selected_pokemon).flatten

	pokemon_data
end

def pokemon_view_browse(language_id = 9)
	language_id == "en" ? language_id = 9 : language_id
	pocket_ids_and_names = get_item_pocket_ids_and_names(language_id)

	{
		gens: get_all_generations(language_id),
		pocket_ids_and_names: pocket_ids_and_names,
		lang: LANGUAGE_CODES.key(language_id)
	}
end

def pokemon_view_items_by_pocket(pocket_id, language_id = 9)
	language_id == "en" ? language_id = 9 : language_id

	{
		items: get_items_by_category(pocket_id, language_id),
		pocket_name: get_item_pocket_name(pocket_id, language_id),
		lang: LANGUAGE_CODES.key(language_id)
	}
end
