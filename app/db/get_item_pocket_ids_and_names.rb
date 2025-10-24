def get_item_pocket_ids_and_names(language_id = 9)
	DB.execute("select item_pocket_id, name from pokemon_v2_itempocketname where language_id = ?;", language_id)
end
