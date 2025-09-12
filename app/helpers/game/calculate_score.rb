def calculate_game_score(points, guesses, skips)
	incorrect = guesses - points
	score = points - incorrect * 0.5 - skips * 0.1
	return [score.round, 0].max
end