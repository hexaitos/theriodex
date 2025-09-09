def get_game_info(id, language_id=9, difficulty="easy")
	name = get_pokemon_name(id, language_id)
	hints = {}

	case difficulty
	when "easy"
		hints[:first_letter] = name[0].upcase
		hints[:last_letter] = name[name.length - 1].upcase
		blur = rand(2..5)
	when "medium"
		hints[:first_letter] = name[0].upcase
		hints[:last_letter] = "Disabled"
		blur = rand(7..13)
	when "hard"
		hints[:first_letter] = "Disabled"
		hints[:last_letter] = "Disabled"
		blur = rand(12..20)
	end

	return 	{
				:id => id,
				:name => name,
				:lang => LANGUAGE_CODES.key(language_id),
				:sprite => get_pokemon_sprites(id)[:front_sprite],
				:hints => hints,
				:blur => blur
			}
end