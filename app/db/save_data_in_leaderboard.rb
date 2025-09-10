def save_data_in_leaderboard(username)
	md5 = Digest::MD5.new
	database_data = {
		'points' => session[:points],
		'guesses' => session[:guesses],
		'skips' => session[:skips]
	}
	
	REDIS.zadd("scores", session[:points], "#{username}-#{Digest::SHA1.hexdigest(Time.now.to_s)}")
end