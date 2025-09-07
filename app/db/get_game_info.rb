def get_game_info(id, language_id=9)
	return 	{
				:id => id,
				:name => get_pokemon_name(id, language_id),
				:lang => LANGUAGE_CODES.key(language_id),
				:sprite => get_pokemon_sprites(id)[:front_sprite]
			}
end