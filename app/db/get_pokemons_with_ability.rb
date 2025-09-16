def get_pokemons_with_ability(ability_id)
	DB.execute("select pokemon_id from pokemon_v2_pokemonability where ability_id = ? and pokemon_id <= 1024;", ability_id)
end
