def get_all_sprites(pokemon_id)
	if pokemon_id.to_i > 1024 then
		sprites_json = JSON.parse(DB.get_first_value("select sprites from pokemon_v2_pokemonformsprites where pokemon_form_id = ?", pokemon_id).to_s)
	else
		sprites_json = JSON.parse(DB.get_first_value("select sprites from pokemon_v2_pokemonsprites where pokemon_id = ?", pokemon_id).to_s)
	end

	sprites_json
end
