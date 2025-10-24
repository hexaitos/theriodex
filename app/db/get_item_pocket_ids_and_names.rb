def get_item_pocket_ids_and_names(language_id = 9)
	data = DB.execute("select item_pocket_id, name from pokemon_v2_itempocketname where language_id = ?;", language_id)

	data = get_item_pocket_ids_and_names(9) if data.nil? or data.length == 0

	return data
end
