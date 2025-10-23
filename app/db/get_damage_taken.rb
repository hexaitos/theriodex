def damage_taken(types)
	pokemon_damage_taken = []

	if types.size == 1 then
		pokemon_damage_taken = DB.execute("select damage_type_id, case when count(*) = 1 then max(damage_factor) when min(damage_factor) = 0 then 0 else round((min(damage_factor) * max(damage_factor)) / 100.0) end as combined_damage_factor from pokemon_v2_typeefficacy where target_type_id in (?) group by damage_type_id order by damage_type_id asc;", types[0])
	else
		pokemon_damage_taken = DB.execute("select damage_type_id, case when count(*) = 1 then max(damage_factor) when min(damage_factor) = 0 then 0 else round((min(damage_factor) * max(damage_factor)) / 100.0) end as combined_damage_factor from pokemon_v2_typeefficacy where target_type_id in (?, ?) group by damage_type_id order by damage_type_id asc;", [ types[0], types[1] ])
	end

	pokemon_damage_taken
end
