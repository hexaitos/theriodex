def get_versions_from_gen(gen, language_id = 9)
	DB.execute("select vn.name as version_name from pokemon_v2_versionname vn join pokemon_v2_version v on vn.version_id = v.id join pokemon_v2_versiongroup vg on v.version_group_id = vg.id join pokemon_v2_generation g on vg.generation_id = g.id where vn.language_id = ? and g.id = ?;", [ language_id, gen ])
end
