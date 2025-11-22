def get_pokemon_game_versions(language_id = 9)
	DB.execute(<<-SQL, language_id)

	SELECT
		GROUP_CONCAT(vn.name, ' & ') AS versions,
		v.version_group_id
	FROM pokemon_v2_versionname vn
		JOIN pokemon_v2_version v
			ON vn.version_id = v.id
	WHERE vn.language_id = ?
	GROUP BY v.version_group_id
	ORDER BY v.version_group_id;
	SQL
end
