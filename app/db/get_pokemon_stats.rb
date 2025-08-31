def get_pokemon_stats(pokemon_id)
	stats = DB.execute("select base_stat from pokemon_v2_pokemonstat where pokemon_id = ? order by stat_id;", pokemon_id)

	return {
			:hp => stats[0].first.to_i,
			:atk => stats[1].first.to_i,
			:def => stats[2].first.to_i,
			:spatk => stats[3].first.to_i,
			:spdef => stats[4].first.to_i,
			:speed => stats[5].first.to_i
			}
end