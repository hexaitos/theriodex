def get_pokemon_generation(id, lang = 9)
	generation_info = DB.execute("select name, generation_id from pokemon_v2_generationname where generation_id in (select generation_id from pokemon_v2_pokemonspecies where id = ?) and language_id=?;", [ id, lang ]).first

	generation_info = get_pokemon_generation(id, 9) if generation_info.length == 0

	generation_info
end
