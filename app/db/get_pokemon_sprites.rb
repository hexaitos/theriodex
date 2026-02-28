def get_pokemon_sprites(pokemon_id)

	sprites_formatted = {}

	if pokemon_id.to_i > 1024 then
		sprites_json = JSON.parse(DB.get_first_value("select sprites from pokemon_v2_pokemonformsprites where pokemon_form_id = ?", pokemon_id).to_s)
	else
		sprites_json = JSON.parse(DB.get_first_value("select sprites from pokemon_v2_pokemonsprites where pokemon_id = ?", pokemon_id).to_s)
	end

	# Male / Default
	unless sprites_json.dig("front_default").nil? then
		sprites_formatted[:front_sprite] = sprites_json.dig("front_default").gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
	else
		sprites_json = JSON.parse(DB.get_first_value("select sprites from pokemon_v2_pokemonsprites where pokemon_id = ?", get_pokemon_base_form(pokemon_id).first["pokemon_form_id"].to_s))

		sprites_formatted[:front_sprite] = sprites_json.dig("front_default").gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
	end
	unless sprites_json.dig("back_default").nil? then sprites_formatted[:back_sprite] = sprites_json.dig("back_default").gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end
	unless sprites_json.dig("front_shiny").nil? then sprites_formatted[:front_shiny] = sprites_json.dig("front_shiny").gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end
	unless sprites_json.dig("back_shiny").nil? then sprites_formatted[:back_shiny] = sprites_json.dig("back_shiny").gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	# Female
	unless sprites_json.dig("front_female").nil? then sprites_formatted[:front_female] = sprites_json.dig("front_female").gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end
	unless sprites_json.dig("back_female").nil? then sprites_formatted[:back_female] = sprites_json.dig("back_female").gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end
	unless sprites_json.dig("front_shiny_female").nil? then sprites_formatted[:front_shiny_female] = sprites_json.dig("front_shiny_female").gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end
	unless sprites_json.dig("back_shiny_female").nil? then sprites_formatted[:back_shiny_female] = sprites_json.dig("back_shiny_female").gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	# Animated Default
	unless sprites_json.dig("versions", "generation-v", "black-white", "animated", "front_default").nil? then sprites_formatted[:animated_front] = sprites_json.dig("versions", "generation-v", "black-white", "animated", "front_default").gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end
	unless sprites_json.dig("versions", "generation-v", "black-white", "animated", "back_default").nil? then sprites_formatted[:animated_back] = sprites_json.dig("versions", "generation-v", "black-white", "animated", "back_default").gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	# Animated Shiny
	unless sprites_json.dig("versions", "generation-v", "black-white", "animated", "front_shiny").nil? then sprites_formatted[:animated_front_shiny] = sprites_json.dig("versions", "generation-v", "black-white", "animated", "front_shiny").gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end
	unless sprites_json.dig("versions", "generation-v", "black-white", "animated", "back_shiny").nil? then sprites_formatted[:animated_back_shiny] = sprites_json.dig("versions", "generation-v", "black-white", "animated", "back_shiny").gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	sprites_formatted
end
