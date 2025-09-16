def get_pokemon_calls(pokemon_id)
	JSON.parse(DB.get_first_value("select cries from pokemon_v2_pokemoncries where pokemon_id = ?;", pokemon_id).to_s)["latest"].gsub("https://raw.githubusercontent.com/PokeAPI/cries/main", "")
end
