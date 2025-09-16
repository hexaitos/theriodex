def get_pokemon_attr(pokemon_id)
	DB.execute("select weight, height from pokemon_v2_pokemon where pokemon_species_id = ?", pokemon_id).first
end
