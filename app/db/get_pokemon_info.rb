def get_pokemon_info(pokemon_id, language_id = 9)
	pokemon_data = {}

	pokemon_id_form = pokemon_id
	pokemon_id = get_pokemon_base_form(pokemon_id, language_id).first["pokemon_form_id"]

	sprites = get_pokemon_sprites(pokemon_id_form)
	attrs = get_pokemon_attr(pokemon_id)
	evolutions = get_pokemon_evolutions(pokemon_id, language_id)

	pokemon_data[:types] = get_pokemon_types(pokemon_id)
	pokemon_data[:flavour_text] = get_pokemon_flavour_text(pokemon_id, language_id)
	pokemon_data[:species_name] = get_pokemon_genus(pokemon_id, language_id)
	pokemon_data[:evolutions] = evolutions[:raw]
	pokemon_data[:forms] = get_pokemon_forms(pokemon_id, language_id)
	pokemon_data[:evolutions_formatted] = evolutions[:formatted]
	pokemon_data[:name] = get_pokemon_name(pokemon_id, language_id)
	pokemon_data[:form_name] = pokemon_data[:forms].find { |p| p["id"].to_i == pokemon_id_form.to_i }&.dig("name")
	pokemon_data[:pokemon_id_form2] = pokemon_data[:forms].find { |p| p["id"].to_i == pokemon_id_form.to_i }&.dig("pokemon_id")
	abilities = get_pokemon_abilities(pokemon_data[:pokemon_id_form2], language_id)
	if abilities.empty?
		pokemon_data[:abilities] = get_pokemon_abilities(pokemon_id, language_id)
	else
		pokemon_data[:abilities] = abilities
	end
	puts "#{pokemon_data[:abilities]}"

	pokemon_data[:calls] = get_pokemon_calls(pokemon_id)

	pokemon_data[:weight] = attrs[0].to_f
	pokemon_data[:height] = attrs[1].to_f
	pokemon_data[:stats] = get_pokemon_stats(pokemon_id_form)
	pokemon_data[:gen] = get_pokemon_generation(pokemon_id_form.to_i, language_id)
	pokemon_data[:moves] = get_pokemon_moves(pokemon_id, language_id)

	pokemon_data[:sprite] = sprites[:front_sprite]
	pokemon_data[:sprite_back] = sprites[:back_sprite]
	pokemon_data[:front_shiny] = sprites[:front_shiny]
	pokemon_data[:back_shiny] = sprites[:back_shiny]

	pokemon_data[:front_female] = sprites[:front_female]
	pokemon_data[:back_female] = sprites[:back_female]
	pokemon_data[:front_shiny_female] = sprites[:front_shiny_female]
	pokemon_data[:back_shiny_female] = sprites[:back_shiny_female]

	pokemon_data[:animated_front] = sprites[:animated_front]
	pokemon_data[:animated_back] = sprites[:animated_back]
	pokemon_data[:animated_front_shiny] = sprites[:animated_front_shiny]
	pokemon_data[:animated_back_shiny] = sprites[:animated_back_front]
	pokemon_data[:lang] = LANGUAGE_CODES.key(language_id)
	pokemon_data[:pokemon_id] = pokemon_id
	pokemon_data[:pokemon_id_form] = pokemon_id_form
	pokemon_data[:no_base_form] = pokemon_data[:forms].any? { |f| f["id"].to_i == pokemon_id.to_i }

	pokemon_data
end
