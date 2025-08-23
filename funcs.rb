class String
	def is_integer?
		self.to_i.to_s == self
	end
end

# TODO instead of opening the every time, maybe open the DB ONCE as soon as the server starts and then just get everything from the variables? Would probably make it quite a bit faster I am imagining
# TODO all the gsub and stuff… maybe I can make a method that formats stuff how I want it to instead

DB = SQLite3::Database.new "db.sqlite3"

def get_pokemon_info_by_name(pokemon_name)
	pokemon_data = {}
	pokemon_data[:evolutions] = []
	pokemon_id = DB.get_first_value("select id from pokemon_v2_pokemon where name = '#{pokemon_name}';").to_i
	pokemon_data = get_pokemon_info(pokemon_id)
	pokemon_data[:id] = pokemon_id
	return pokemon_data
end

def get_pokemon_info(pokemon_id)
	pokemon_data = {}
	sprites = get_pokemon_sprites(pokemon_id)
	attrs = get_pokemon_attr(pokemon_id)
	puts "Attrs #{attrs}"

	pokemon_data[:types] = get_pokemon_types(pokemon_id)
	pokemon_data[:flavour_text] = get_pokemon_flavour_text(pokemon_id)
	pokemon_data[:species_name] = get_pokemon_genus(pokemon_id)
	pokemon_data[:evolutions] = get_pokemon_evolutions(pokemon_id)
	pokemon_data[:name] = get_pokemon_name(pokemon_id)
	pokemon_data[:weight] = attrs[0].to_f
	pokemon_data[:height] = attrs[1].to_f
	pokemon_data[:sprite] = sprites[:front_sprite]
	pokemon_data[:sprite_back] = sprites[:back_sprite]
	pokemon_data[:front_shiny] = sprites[:front_shiny]
	pokemon_data[:back_shiny] = sprites[:back_shiny]

	return pokemon_data
end

def get_pokemon_name(pokemon_id)
	return format_pokemon_name(DB.get_first_value("select name from pokemon_v2_pokemon where pokemon_species_id = #{pokemon_id};").to_s)
end

def get_pokemon_sprites(pokemon_id)
	sprites_formatted = {}
	sprites_json = JSON.parse(DB.get_first_value("select sprites from pokemon_v2_pokemonsprites where pokemon_id = #{pokemon_id};").to_s)

	sprites_formatted[:front_sprite] = sprites_json["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")

	unless sprites_json["back_default"].nil? then sprites_formatted[:back_sprite] = sprites_json["back_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	unless sprites_json["front_shiny"].nil? then sprites_formatted[:front_shiny] = sprites_json["front_shiny"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	unless sprites_json["back_shiny"].nil? then sprites_formatted[:back_shiny] = sprites_json["back_shiny"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") end

	return sprites_formatted
end

def get_pokemon_evolutions(pokemon_id)
	evolutions = []

	DB.execute("select ps2.name from pokemon_v2_pokemonspecies ps2 join pokemon_v2_pokemonspecies ps on ps2.evolution_chain_id = ps.evolution_chain_id join pokemon_v2_pokemon p on p.name = ps.name where p.pokemon_species_id = #{pokemon_id};").each do |form|
		evolutions << form.first.to_s
	end

	return evolutions
end

def get_pokemon_attr(pokemon_id)
	return DB.execute("select weight, height from pokemon_v2_pokemon where pokemon_species_id = #{pokemon_id};").first
end

def get_pokemon_types(pokemon_id)
	return DB.execute("select type_id from pokemon_v2_pokemontype where pokemon_id = #{pokemon_id}")
end

def get_pokemon_flavour_text(pokemon_id)
	return DB.get_first_value("select flavor_text from pokemon_v2_pokemonspeciesflavortext where pokemon_species_id = #{pokemon_id} and language_id = 9 order by random() limit 1;").to_s.gsub("", " ")
end

def get_pokemon_genus(pokemon_id)
	return DB.get_first_value("select genus from pokemon_v2_pokemonspeciesname where language_id = 9 and pokemon_species_id = #{pokemon_id};").to_s
end

def damage_taken(types)
	pokemon_damage_taken = []

	if types.size == 1 then
		pokemon_damage_taken = DB.execute("select damage_type_id, case when count(*) = 1 then max(damage_factor) when min(damage_factor) = 0 then 0 else round((min(damage_factor) * max(damage_factor)) / 100.0) end as combined_damage_factor from pokemon_v2_typeefficacy where target_type_id in (#{types[0].first}) group by damage_type_id order by damage_type_id asc;")
	else
		pokemon_damage_taken = DB.execute("select damage_type_id, case when count(*) = 1 then max(damage_factor) when min(damage_factor) = 0 then 0 else round((min(damage_factor) * max(damage_factor)) / 100.0) end as combined_damage_factor from pokemon_v2_typeefficacy where target_type_id in (#{types[0].first}, #{types[1].first}) group by damage_type_id order by damage_type_id asc;")
	end
	
	return pokemon_damage_taken
end

def search_for_pokemon(query)
	search_results = ""
	pokemon_names = DB.execute("select name from pokemon_v2_pokemon;")
	pokemon_forms = DB.execute("select id, name from pokemon_v2_pokemonform where form_name <> '';")
	matches = FuzzyMatch.new(pokemon_names, :find_all_with_score =>true).find(query)

	matches.each do |key,value|
		# TODO this is all just kinda garbage omg I need to make this not terrible
		pokemon_id = DB.get_first_value("select pokemon_species_id from pokemon_v2_pokemon where name = '#{key.first.to_s}';").to_s

		if pokemon_forms.map(&:last).include?(key.first.to_s) then
			id_by_form = pokemon_forms.map(&:reverse).to_h
			puts id = id_by_form[key.first.to_s]
			puts key.first.to_s
			begin
				puts pokemon_sprite = JSON.parse(DB.execute("select sprites from pokemon_v2_pokemonformsprites where pokemon_form_id = #{id};").first.first.to_s)["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
			rescue
				pokemon_sprite = JSON.parse(DB.execute("select sprites from pokemon_v2_pokemonsprites where pokemon_id = #{pokemon_id};").first.first.to_s)["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
			end
		else

		pokemon_sprite = JSON.parse(DB.execute("select sprites from pokemon_v2_pokemonsprites where pokemon_id = #{pokemon_id};").first.first.to_s)["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
		end

		search_results << "<a href='/show/#{pokemon_id}'><img src='#{pokemon_sprite}'/><br/>#{format_pokemon_name(key.first.to_s)}<br/></a>" if value >= 0.25
	end

	return search_results
end

def format_pokemon_name(pokemon_name)
	suffixes = {
		"f" => " (f)",
		"m" => " (m)",
		"gliding-build" => " (gliding build)",
		"sprinting-build" => " (sprinting build)",
		"swimming-build" => " (swimming build)",
		"origin" => " (origin)",
		"limited-build" => "(limited build)",
		"yellow" => " (yellow)",
		"drive-mode" => " (drive mode)",
		"totem" => " (totem)",
		"average" => " (average)",
		"zero" => " (zero)",
		"solo" => " (solo)",
		"boulder" => " (boulder)",
		"bolt" => " (bolt)",
		"tail" => " (tail)"
	}

	suffixes.each do |suffix, formatted|
		if pokemon_name.sub(/^[^-]*-/, '') == suffix then
			pokemon_name = pokemon_name.capitalize.gsub("-#{suffix}", '') + formatted
		else
			pokemon_name = pokemon_name.capitalize
		end
	end

	return pokemon_name
end

# TODO everything is confusing and doesn't work how I want it to aaaa maybe just leaves this out not sure if this is a good idea
# The intent is to show a random sprite if there are several sprites, but sometimes other sprites actually have other stats or something like with Oricorio's different forms
def get_random_sprite(pokemon_id)
	db = SQLite3::Database.new "db.sqlite3"
	pokemon_name = db.get_first_value("select name from pokemon_v2_pokemon where pokemon_species_id = #{pokemon_id};").to_s
	pokemon_name_clean = pokemon_name.sub(/-.*/, '')
	pokemon_forms = db.execute("select id, name from pokemon_v2_pokemonform where form_name <> '' and name like '#{pokemon_name_clean}%' order by random();")

	if pokemon_forms.map(&:last).include?(pokemon_name) then
		puts pokemon_forms.first.first
		puts pokemon_name
	end
end

puts get_random_sprite(741)
