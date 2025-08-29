def pokemon_view_moves(id, language_id=9)
	id = Sanitize.fragment(id)

	return 	{
				:moves => get_pokemon_moves(id)
			}
end

def pokemon_view_ability(id, language_id=9)
	id = Sanitize.fragment(id)
	pokemon_with_ability_raw = get_pokemons_with_ability(id)
	pokemon_with_ability = {}

	ability_name = get_pokemon_ability_name(id)
	raise Sinatra::NotFound if ability_name.nil?
	
	pokemon_with_ability_raw.each do | pokemon |
		puts pokemon.first
		pokemon_with_ability[pokemon.first] = {}
		pokemon_with_ability[pokemon.first][:name] = get_pokemon_name(pokemon.first)
		pokemon_with_ability[pokemon.first][:sprite] = get_pokemon_sprites(pokemon.first)[:front_sprite]
	end

	return 	{
				:ability_information => get_pokemon_ability_information(id),
				:pokemon_with_ability => pokemon_with_ability,
				:ability_name => get_pokemon_ability_name(id)
			}
end

def pokemon_view_index(id, form=nil, s=nil, animated=false, language_id=9)
	selected_pokemon = Sanitize.fragment(id)
	selected_sex = Sanitize.fragment(s)
	animated = Sanitize.fragment(animated) unless !animated
	
	# I only just learnt about these things called ternary operators? So of course I am going to try using them now even though I could have also just have written an if statement
	form.nil? ? selected_form = nil : selected_form = Sanitize.fragment(form)
	s.nil? ? selected_sex = nil : selected_sex = Sanitize.fragment(s)

	begin
		selected_pokemon.is_integer? ? pokemon_data = get_pokemon_info(selected_pokemon, language_id) : pokemon_data = get_pokemon_info_by_name(selected_pokemon)
	rescue JSON::ParserError
		raise Sinatra::NotFound
	end

	puts "(#{Time.now.strftime('%d.%m-%Y %H:%M')}) - The following Pokémon was selected: #{selected_pokemon}.\n The following data was returned: #{pokemon_data}\n\n"

	pokemon_data[:id] = selected_pokemon
	pokemon_data[:damage_taken] = damage_taken(pokemon_data[:types])
	pokemon_data[:form] = selected_form
	pokemon_data[:sex] = selected_sex
	pokemon_data[:animated] = animated

	return pokemon_data
end