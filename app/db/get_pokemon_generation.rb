def get_pokemon_generation(id, lang = 9)
	is_available = DB.get_first_value("SELECT * FROM pokemon_v2_generationname WHERE generation_id IN (SELECT generation_id FROM pokemon_v2_pokemonspecies WHERE id = ?) UNION ALL SELECT * FROM pokemon_v2_generationname WHERE generation_id IN (SELECT generation_id FROM pokemon_v2_pokemonformgeneration WHERE pokemon_form_id = ?) LIMIT 1", id, id)

	generation_info = DB.execute("select name, generation_id from pokemon_v2_generationname where generation_id in (select generation_id from pokemon_v2_pokemonspecies where id = ?) and language_id=?;", [ id, lang ]).first if id <= 1024

	generation_info = DB.execute("select name, generation_id from pokemon_v2_generationname where generation_id in (select generation_id from pokemon_v2_pokemonformgeneration where pokemon_form_id = ?) and language_id= ? limit 1;", [ id, lang ]).first if id > 1024

	generation_info = get_pokemon_generation(id, 9) if (generation_info.nil? or generation_info.length == 0) and is_available

	generation_info = "X" if !is_available

	generation_info
end
