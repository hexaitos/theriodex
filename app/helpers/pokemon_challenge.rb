def get_pokemon_for_day()
	today = Date.today
	day_num = (today - POKEMON_CHALLENGE_START_DATE).to_i
	start_pos = day_num * POKEMON_CHALLENGE_NUM

	return POKEMON_CHALLENGE_IDS[start_pos..(start_pos+POKEMON_CHALLENGE_NUM)-1]
end
