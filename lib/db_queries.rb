require_relative 'vars.rb'

def get_pokemon_info_by_name(pokemon_name, language_id=9)
	pokemon_id = DB.get_first_value("select id from pokemon_v2_pokemon where pokemon_species_id in (select pokemon_species_id from pokemon_v2_pokemonspeciesname where lower(name) = lower( ? )) limit 1;", pokemon_name).to_i
	pokemon_data = get_pokemon_info(pokemon_id, language_id)
	return pokemon_data
end

def get_pokemon_info(pokemon_id, language_id=9)
	pokemon_data = {}
	sprites = get_pokemon_sprites(pokemon_id)
	attrs = get_pokemon_attr(pokemon_id)
	evolutions = get_pokemon_evolutions(pokemon_id, language_id)

	pokemon_data[:types] = get_pokemon_types(pokemon_id)
	pokemon_data[:flavour_text] = get_pokemon_flavour_text(pokemon_id, language_id)
	pokemon_data[:species_name] = get_pokemon_genus(pokemon_id, language_id)
	pokemon_data[:evolutions] = evolutions[:raw]
	pokemon_data[:evolutions_formatted] = evolutions[:formatted]
	pokemon_data[:name] = get_pokemon_name(pokemon_id, language_id)
	pokemon_data[:abilities] = get_pokemon_abilities(pokemon_id, language_id)

	pokemon_data[:weight] = attrs[0].to_f
	pokemon_data[:height] = attrs[1].to_f
	pokemon_data[:stats] = get_pokemon_stats(pokemon_id)

	pokemon_data[:sprite] = sprites[:front_sprite]
	pokemon_data[:sprite_back] = sprites[:back_sprite]
	pokemon_data[:front_shiny] = sprites[:front_shiny]
	pokemon_data[:back_shiny] = sprites[:back_shiny]

	pokemon_data[:front_female] = sprites[:front_female]
	pokemon_data[:back_female] = sprites[:back_female]
	pokemon_data[:front_shiny_female] = sprites[:front_shiny_female]
	pokemon_data[:back_shiny_female] = sprites[:back_shiny_female]

	pokemon_data[:animated_front] = sprites[:animated_front]
	pokemon_data[:animated_back] = sprites[:animated_back]
	pokemon_data[:animated_front_shiny] = sprites[:animated_front_shiny]
	pokemon_data[:animated_back_shiny] = sprites[:animated_back_front]
	pokemon_data[:lang] = LANGUAGE_CODES.key(language_id)

	return pokemon_data
end

def get_pokemon_name(pokemon_id, language_id=9)
	return format_pokemon_name(DB.get_first_value("select name from pokemon_v2_pokemonspeciesname where pokemon_species_id = ? and language_id = ?;", [pokemon_id, language_id]).to_s)
end

def get_pokemon_sprites(pokemon_id)
	sprites_formatted = {}
	sprites_json = JSON.parse(DB.get_first_value("select sprites from pokemon_v2_pokemonsprites where pokemon_id = ?", pokemon_id).to_s)

	# Male / Default
	sprites_formatted[:front_sprite] = sprites_json["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")

	unless sprites_json["back_default"].nil? then sprites_formatted[:back_sprite] = sprites_json["back_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	unless sprites_json["front_shiny"].nil? then sprites_formatted[:front_shiny] = sprites_json["front_shiny"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	unless sprites_json["back_shiny"].nil? then sprites_formatted[:back_shiny] = sprites_json["back_shiny"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	# Female
	unless sprites_json["front_female"].nil? then sprites_formatted[:front_female] = sprites_json["front_female"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	unless sprites_json["back_female"].nil? then sprites_formatted[:back_female] = sprites_json["back_female"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	unless sprites_json["front_shiny_female"].nil? then sprites_formatted[:front_shiny_female] = sprites_json["front_shiny_female"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	unless sprites_json["back_shiny_female"].nil? then sprites_formatted[:back_shiny_female] = sprites_json["back_shiny_female"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	# Animated Default
	unless sprites_json["versions"]["generation-v"]["black-white"]["animated"]["front_default"].nil? then sprites_formatted[:animated_front] = sprites_json["versions"]["generation-v"]["black-white"]["animated"]["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	unless sprites_json["versions"]["generation-v"]["black-white"]["animated"]["back_default"].nil? then sprites_formatted[:animated_back] = sprites_json["versions"]["generation-v"]["black-white"]["animated"]["back_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	# Animated Shiny
	unless sprites_json["versions"]["generation-v"]["black-white"]["animated"]["front_shiny"].nil? then sprites_formatted[:animated_front_shiny] = sprites_json["versions"]["generation-v"]["black-white"]["animated"]["front_shiny"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	unless sprites_json["versions"]["generation-v"]["black-white"]["animated"]["back_shiny"].nil? then sprites_formatted[:animated_back_shiny] = sprites_json["versions"]["generation-v"]["black-white"]["animated"]["back_shiny"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	return sprites_formatted
end

def get_pokemon_evolutions(pokemon_id, language_id=9)
	evolutions = {}
	evolutions[:raw] = []
	evolutions[:formatted] = {}

	DB.execute("select ps2n.name as localised_name from pokemon_v2_pokemonspecies ps2 join pokemon_v2_pokemonspecies ps on ps2.evolution_chain_id = ps.evolution_chain_id join pokemon_v2_pokemon p on p.name = ps.name join pokemon_v2_pokemonspeciesname ps2n on ps2.id = ps2n.pokemon_species_id where p.pokemon_species_id = ? and ps2n.language_id = ?;", [pokemon_id, language_id]).each do |form|
		evolutions[:raw] << form.first.to_s.downcase
		evolutions[:formatted][form.first.to_s.downcase] = form.first.to_s
	end

	return evolutions
end

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

def get_pokemon_attr(pokemon_id)
	return DB.execute("select weight, height from pokemon_v2_pokemon where pokemon_species_id = ?", pokemon_id).first
end

def get_pokemon_types(pokemon_id)
	return DB.execute("select type_id from pokemon_v2_pokemontype where pokemon_id = ?", pokemon_id)
end

def get_pokemon_flavour_text(pokemon_id, language_id=9)
	return DB.get_first_value("select flavor_text from pokemon_v2_pokemonspeciesflavortext where pokemon_species_id = ? and language_id = ? order by random() limit 1;", [pokemon_id, language_id]).to_s.gsub("", " ").gsub("\n", " ").gsub("  ", "")
end

def get_pokemon_genus(pokemon_id, language_id=9)
	return DB.get_first_value("select genus from pokemon_v2_pokemonspeciesname where language_id = ? and pokemon_species_id = ?;", [language_id, pokemon_id]).to_s
end

def get_pokemon_abilities(pokemon_id, language_id=9)
	return DB.execute("select an.name as ability_name, pa.is_hidden, pa.slot, pa.ability_id, a.name from pokemon_v2_pokemonability as pa join pokemon_v2_ability as a on pa.ability_id = a.id join pokemon_v2_abilityname as an on an.ability_id = a.id where pa.pokemon_id = ? and an.language_id = ? order by pa.slot;", [pokemon_id, language_id])
end

def get_pokemon_ability_name(ability_id, language_id=9)
	return DB.get_first_value("select name from pokemon_v2_abilityname where ability_id = ? and language_id = ?;", [ability_id, language_id])
end

def get_pokemon_ability_information(ability_id, language_id=9)
	if DB.get_first_value("select effect from pokemon_v2_abilityeffecttext where language_id = ? and ability_id = ?;", [language_id, ability_id]).nil? then
		return DB.get_first_value("select flavor_text from pokemon_v2_abilityflavortext where language_id = ? and ability_id = ? order by random() limit 1;", [language_id, ability_id])
	else
		return DB.get_first_value("select effect from pokemon_v2_abilityeffecttext where language_id = ? and ability_id = ?;", [language_id, ability_id])
	end
end

def get_pokemons_with_ability(ability_id)
	return DB.execute("select pokemon_id from pokemon_v2_pokemonability where ability_id = ? and pokemon_id <= 1024;", ability_id)
end

puts "#{get_pokemon_abilities(134)}"

def damage_taken(types)
	pokemon_damage_taken = []

	if types.size == 1 then
		pokemon_damage_taken = DB.execute("select damage_type_id, case when count(*) = 1 then max(damage_factor) when min(damage_factor) = 0 then 0 else round((min(damage_factor) * max(damage_factor)) / 100.0) end as combined_damage_factor from pokemon_v2_typeefficacy where target_type_id in (?) group by damage_type_id order by damage_type_id asc;", types[0].first)
	else
		pokemon_damage_taken = DB.execute("select damage_type_id, case when count(*) = 1 then max(damage_factor) when min(damage_factor) = 0 then 0 else round((min(damage_factor) * max(damage_factor)) / 100.0) end as combined_damage_factor from pokemon_v2_typeefficacy where target_type_id in (?, ?) group by damage_type_id order by damage_type_id asc;", [types[0].first, types[1].first])
	end

	return pokemon_damage_taken
end

def format_flavour_text(txt)

end

def get_pokemon_moves(pokemon_id, language_id=9)
	return DB.execute("select move_id, name from pokemon_v2_movename where language_id = ? and move_id in (select distinct move_id from pokemon_v2_pokemonmove where pokemon_id = ?);", [language_id, pokemon_id])
end

def get_pokemon_moves_information(pokemon_id, moves)
	moves_information = []

	moves.each do | move |
		moves_information << DB.execute("select level, version_group_id from pokemon_v2_pokemonmove where move_id = ? and pokemon_id = ?;", move.first, pokemon_id)
	end

	return moves_information
end

def search_for_pokemon(query)
	search_results = ""
	query = Sanitize.fragment(query)
	pokemon_names = DB.execute("select name from pokemon_v2_pokemon;")
	pokemon_forms = DB.execute("select id, name from pokemon_v2_pokemonform where form_name <> '';")
	matches = FuzzyMatch.new(pokemon_names, :find_all_with_score => true).find(query)

	matches.each do |key,value|
		# TODO this is all just kinda garbage omg I need to make this not terrible
		pokemon_id = DB.get_first_value("select pokemon_species_id from pokemon_v2_pokemon where name = ?;", key.first.to_s).to_s

		if pokemon_forms.map(&:last).include?(key.first.to_s) then
			id_by_form = pokemon_forms.map(&:reverse).to_h
			id = id_by_form[key.first.to_s]
			key.first.to_s
			begin
				pokemon_sprite = JSON.parse(DB.execute("select sprites from pokemon_v2_pokemonformsprites where pokemon_form_id = ?;", id).first.first.to_s)["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
			rescue
				pokemon_sprite = JSON.parse(DB.execute("select sprites from pokemon_v2_pokemonsprites where pokemon_id = ?;", pokemon_id).first.first.to_s)["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
			end
		else

		pokemon_sprite = JSON.parse(DB.execute("select sprites from pokemon_v2_pokemonsprites where pokemon_id = ?;", pokemon_id).first.first.to_s)["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
		end

		search_results << "<a href='/show/#{pokemon_id}'><img src='#{pokemon_sprite}'/><br/>#{format_pokemon_name(key.first.to_s)}<br/></a>" if value >= 0.25
	end

	return search_results
end
