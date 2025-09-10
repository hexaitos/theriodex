def save_data_in_leaderboard(username)
	score = calculate_game_score(session[:points], session[:guesses], session[:skips])
	REDIS.zadd("scores", score, "#{username}-#{Digest::SHA1.hexdigest(Time.now.to_s)}")
end