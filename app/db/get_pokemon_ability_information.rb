def get_pokemon_ability_information(ability_id, language_id=9)
	if DB.get_first_value("select effect from pokemon_v2_abilityeffecttext where language_id = ? and ability_id = ?;", [language_id, ability_id]).nil? then
		return DB.get_first_value("select flavor_text from pokemon_v2_abilityflavortext where language_id = ? and ability_id = ? order by random() limit 1;", [language_id, ability_id])
	else
		return DB.get_first_value("select effect from pokemon_v2_abilityeffecttext where language_id = ? and ability_id = ?;", [language_id, ability_id])
	end
end