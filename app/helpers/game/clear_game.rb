def clear_game
	[ :database_username, :difficulty, :gen, :guesses, :points, :pokemon_info, :results, :saved_in_leaderboard, :serial, :skips, :unlocked_themes, :username ].each { |key| session[key] = nil }
end
