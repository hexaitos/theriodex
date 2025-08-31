def get_pokemon_ability_name(ability_id, language_id=9)
	return DB.get_first_value("select name from pokemon_v2_abilityname where ability_id = ? and language_id = ?;", [ability_id, language_id])
end