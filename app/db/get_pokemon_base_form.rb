GET_POKEMON_BASE_FORM = <<-SQL
SELECT
	pf.id as pokemon_form_id,
	COALESCE(pfn.pokemon_name, psn.name) as pokemon_name
FROM pokemon_v2_pokemonspecies ps
JOIN pokemon_v2_pokemon p
	ON p.pokemon_species_id = ps.id
	AND p.is_default = true
JOIN pokemon_v2_pokemonform pf
	ON pf.pokemon_id = p.id
	AND pf.is_default = true
LEFT JOIN pokemon_v2_pokemonformname pfn
	ON pfn.pokemon_form_id = pf.id
	AND pfn.language_id = ?
JOIN pokemon_v2_pokemonspeciesname psn
	ON psn.pokemon_species_id = ps.id
	AND psn.language_id = ?
WHERE ps.id = (
	SELECT ps2.id
	FROM pokemon_v2_pokemonspecies ps2
	JOIN pokemon_v2_pokemon p2 ON p2.pokemon_species_id = ps2.id
	JOIN pokemon_v2_pokemonform pf2 ON pf2.pokemon_id = p2.id
	WHERE ps2.id = ? OR p2.id = ? OR pf2.id = ?
	LIMIT 1
);
SQL

GET_POKEMON_BASE_FORM_Q = DB.prepare(GET_POKEMON_BASE_FORM)

def get_pokemon_base_form(pokemon_id, language_id = 9)
		rs = GET_POKEMON_BASE_FORM_Q.execute(
			[ language_id, language_id, pokemon_id, pokemon_id, pokemon_id ]
		)

		omega_array = []

		rs.each_hash do |hash|
			omega_array << hash
		end

		omega_array
end
