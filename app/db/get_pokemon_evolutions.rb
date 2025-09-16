def get_pokemon_evolutions(pokemon_id, language_id = 9)
	evolutions = {}
	evolutions[:raw] = []
	evolutions[:formatted] = {}

	DB.execute("select ps2n.name as localised_name from pokemon_v2_pokemonspecies ps2 join pokemon_v2_pokemonspecies ps on ps2.evolution_chain_id = ps.evolution_chain_id join pokemon_v2_pokemon p on p.name = ps.name join pokemon_v2_pokemonspeciesname ps2n on ps2.id = ps2n.pokemon_species_id where p.pokemon_species_id = ? and ps2n.language_id = ?;", [ pokemon_id, language_id ]).each do |form|
		evolutions[:raw] << form.first.to_s.downcase
		evolutions[:formatted][form.first.to_s.downcase] = form.first.to_s
	end

	evolutions
end
