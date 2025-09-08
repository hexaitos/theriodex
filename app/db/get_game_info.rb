def get_game_info(id, language_id=9)
	name = get_pokemon_name(id, language_id)
	hints = {
				:first_letter => name[0].upcase,
				:last_letter => name[name.length - 1].upcase
			}

	return 	{
				:id => id,
				:name => name,
				:lang => LANGUAGE_CODES.key(language_id),
				:sprite => get_pokemon_sprites(id)[:front_sprite],
				:hints => hints
			}
end