def get_pokemon_stats(pokemon_id)
	stats = DB.execute("select base_stat from pokemon_v2_pokemonstat where pokemon_id = ? order by stat_id;", pokemon_id)

	hp = stats[0]&.first.to_i || "no data"
	atk = stats[1]&.first.to_i || "no data"
	defense = stats[2]&.first.to_i || "no data"
	spatk = stats[3]&.first.to_i || "no data"
	spdef = stats[4]&.first.to_i || "no data"
	speed = stats[5]&.first.to_i || "no data"

	{
		hp: hp,
		atk: atk,
		def: defense,
		spatk: spatk,
		spdef: spdef,
		speed: speed
	}
end
