def get_all_pokemon_sprites(pokemon_id)
	DB.get_first_value("select sprites from pokemon_v2_pokemonsprites where pokemon_id = ?", pokemon_id)
end
