def get_item_pocket_name(pocket_id, language_id = 9)
	data = DB.get_first_value("select name from pokemon_v2_itempocketname where language_id = ? and item_pocket_id = ?;", [ language_id, pocket_id ])

	data = get_item_pocket_name(pocket_id, 9) if data.nil? or data.length == 0

	return data
end
