def get_version_names(version_group_name, language_id = 9)
	version_group_name = "omega-ruby-alpha-sapphire" if version_group_name == "omegaruby-alphasapphire" # I hate this DB sometimes… a lot of the times

	DB.execute(<<~SQL, [ version_group_name, language_id, version_group_name, language_id ])
	SELECT vn.name AS version_name
	FROM pokemon_v2_version v
	JOIN pokemon_v2_versiongroup vg ON v.version_group_id = vg.id
	JOIN pokemon_v2_versionname vn ON vn.version_id = v.id
	WHERE vg.name = ?
	AND vn.language_id = ?

	UNION ALL

	SELECT vn.name AS version_name
	FROM pokemon_v2_version v
	JOIN pokemon_v2_versionname vn ON vn.version_id = v.id
	WHERE v.name = ?
	AND vn.language_id = ?
	SQL
end
