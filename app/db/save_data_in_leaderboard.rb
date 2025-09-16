def save_data_in_leaderboard(username)
	if session[:saved_in_leaderboard]
		override_data_in_leaderboard(session[:database_username], session[:username])
	else
		database_username = "#{username}-#{Time.now.strftime('%Y%m%d%H%M%S')}>#{rand(0..1000000000000)}"
		score = calculate_game_score(session[:points], session[:guesses], session[:skips])
		REDIS.zadd("scores", score, database_username)
		session[:saved_in_leaderboard] ||= true
		session[:database_username] = database_username
	end
end

def override_data_in_leaderboard(database_username, username)
	REDIS.zrem("scores", database_username)

	database_username = "#{username}-#{Time.now.strftime('%Y%m%d%H%M%S')}"
	score = calculate_game_score(session[:points], session[:guesses], session[:skips])
	REDIS.zadd("scores", score, database_username)

	session[:database_username] = database_username
end
