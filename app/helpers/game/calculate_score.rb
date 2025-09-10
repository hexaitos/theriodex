def calculate_game_score(points, guesses, skips)
	return ((guesses - (guesses - points)) - skips * 0.1).to_i
end