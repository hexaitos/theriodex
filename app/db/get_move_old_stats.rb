def get_move_old_stats(move_id)
	DB.results_as_hash = true
	results = DB.execute("select * from pokemon_v2_movechange where move_id = ?", move_id)
	DB.results_as_hash = false

	results
end
