GET_POKEMON_FORMS = <<-SQL
SELECT DISTINCT
	pfn.pokemon_name as name,
	pf.id as id
FROM
	pokemon_v2_pokemonspecies ps2
JOIN
	pokemon_v2_pokemonspecies ps
	ON ps2.evolution_chain_id = ps.evolution_chain_id
JOIN
	pokemon_v2_pokemon p
	ON p.pokemon_species_id = ps2.id
JOIN
	pokemon_v2_pokemonform pf
	ON pf.pokemon_id = p.id
JOIN
	pokemon_v2_pokemonformname pfn
	ON pf.id = pfn.pokemon_form_id AND pfn.language_id = ?
JOIN
	pokemon_v2_pokemonspeciesname ps2n
	ON ps2.id = ps2n.pokemon_species_id AND ps2n.language_id = ?
WHERE
	p.pokemon_species_id = ?;
SQL

GET_POKEMON_FORMS_Q = DB.prepare(GET_POKEMON_FORMS)

def get_pokemon_forms(pokemon_id, language_id = 9)
		rs = GET_POKEMON_FORMS_Q.execute(
			[ language_id, language_id, pokemon_id ]
		)

		omega_array = []

		rs.each_hash do |hash|
			omega_array << hash
		end

		omega_array
end
