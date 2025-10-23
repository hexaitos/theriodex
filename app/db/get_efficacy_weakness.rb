def get_efficacy_weakness(type)
	efficacy_weakness = {}

	efficacy_weakness[:efficacy] = DB.execute("select damage_factor, target_type_id from pokemon_v2_typeefficacy where damage_type_id = ? and (damage_factor < 100 or damage_factor > 100);", type)

	efficacy_weakness[:weakness] = DB.execute("select damage_factor, damage_type_id from pokemon_v2_typeefficacy where target_type_id = ? and (damage_factor < 100 or damage_factor > 100);", type)

	efficacy_weakness
end
