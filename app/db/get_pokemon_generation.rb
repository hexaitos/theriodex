def get_pokemon_generation(id, lang=9)
	generation_name = DB.get_first_value("select name from pokemon_v2_generationname where generation_id in (select generation_id from pokemon_v2_pokemonspecies where id = ?) and language_id=?;", [id, lang])

	if !generation_name
		generation_name = get_pokemon_generation(id, 9)
	end

	return generation_name
end