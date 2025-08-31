def get_pokemon_abilities(pokemon_id, language_id=9)
	return DB.execute("select an.name as ability_name, pa.is_hidden, pa.slot, pa.ability_id, a.name from pokemon_v2_pokemonability as pa join pokemon_v2_ability as a on pa.ability_id = a.id join pokemon_v2_abilityname as an on an.ability_id = a.id where pa.pokemon_id = ? and an.language_id = ? order by pa.slot;", [pokemon_id, language_id])
end