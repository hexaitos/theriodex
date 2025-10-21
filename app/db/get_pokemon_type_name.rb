def get_pokemon_type_name(type, language_id)
	DB.get_first_value("select name from pokemon_v2_typename where type_id = ? and language_id = ?;", [ type, language_id ])
end
