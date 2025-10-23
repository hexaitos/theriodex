def get_all_generations(lang = 9)
	generation_info = DB.execute("select name, generation_id from pokemon_v2_generationname where language_id=?;", lang)

	generation_info = get_all_generations(9) if generation_info.length == 0

	generation_info
end
