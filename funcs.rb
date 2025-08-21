class String
  def is_integer?
    self.to_i.to_s == self
  end
end

class PokemonDataNotFound < StandardError
end

def get_pokemon_info(pokemon_id)
    pokemon_data = {}
    pokemon_data[:evolutions] = []

    db = SQLite3::Database.new "db.sqlite3"

    pokemon_data[:name] = db.get_first_value("select name from pokemon_v2_pokemon where pokemon_species_id = #{pokemon_id};").to_s.capitalize
    pokemon_data[:sprite] = JSON.parse(db.get_first_value("select sprites from pokemon_v2_pokemonsprites where pokemon_id = #{pokemon_id};").to_s)["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
    begin
        pokemon_data[:sprite_back] = JSON.parse(db.get_first_value("select sprites from pokemon_v2_pokemonsprites where pokemon_id = #{pokemon_id};").to_s)["back_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
    rescue NoMethodError
        pokemon_data[:sprite_back] = nil
    end

    pokemon_data[:types] = db.execute("select type_id from pokemon_v2_pokemontype where pokemon_id = #{pokemon_id};")

    pokemon_data[:flavour_text] = db.get_first_value("select flavor_text from pokemon_v2_pokemonspeciesflavortext where pokemon_species_id = #{pokemon_id} and language_id = 9 order by random() limit 1;").to_s.gsub("", " ")

    pokemon_data[:species_name] = db.get_first_value("select genus from pokemon_v2_pokemonspeciesname where language_id = 9 and pokemon_species_id = #{pokemon_id};").to_s

    pokemon_data[:weight] = db.get_first_value("select weight from pokemon_v2_pokemon where pokemon_species_id = #{pokemon_id};").to_f

    pokemon_data[:height] = db.get_first_value("select height from pokemon_v2_pokemon where pokemon_species_id = #{pokemon_id};").to_f

    db.execute("select ps2.name from pokemon_v2_pokemonspecies ps2 join pokemon_v2_pokemonspecies ps on ps2.evolution_chain_id = ps.evolution_chain_id join pokemon_v2_pokemon p on p.name = ps.name where p.pokemon_species_id = #{pokemon_id};").each do |form|
     pokemon_data[:evolutions] << form.first.to_s unless form.first.to_s.capitalize == pokemon_data[:name]
    end

    return pokemon_data
end

def get_pokemon_info_by_name(pokemon_name)
    pokemon_data = {}
    pokemon_data[:evolutions] = []

    db = SQLite3::Database.new "db.sqlite3"

    pokemon_data[:id] = db.get_first_value("select id from pokemon_v2_pokemon where name = '#{pokemon_name}';").to_i
    pokemon_id = pokemon_data[:id]

    pokemon_data[:name] = db.get_first_value("select name from pokemon_v2_pokemon where pokemon_species_id = #{pokemon_id};").to_s.capitalize
    pokemon_data[:sprite] = JSON.parse(db.get_first_value("select sprites from pokemon_v2_pokemonsprites where pokemon_id = #{pokemon_id};").to_s)["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
    begin
        pokemon_data[:sprite_back] = JSON.parse(db.get_first_value("select sprites from pokemon_v2_pokemonsprites where pokemon_id = #{pokemon_id};").to_s)["back_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
    rescue NoMethodError
        pokemon_data[:sprite_back] = nil
    end

    pokemon_data[:types] = db.execute("select type_id from pokemon_v2_pokemontype where pokemon_id = #{pokemon_id};")

    pokemon_data[:flavour_text] = db.get_first_value("select flavor_text from pokemon_v2_pokemonspeciesflavortext where pokemon_species_id = #{pokemon_id} and language_id = 9 order by random() limit 1;").to_s.gsub("", " ")

    pokemon_data[:species_name] = db.get_first_value("select genus from pokemon_v2_pokemonspeciesname where language_id = 9 and pokemon_species_id = #{pokemon_id};").to_s

    pokemon_data[:weight] = db.get_first_value("select weight from pokemon_v2_pokemon where pokemon_species_id = #{pokemon_id};").to_f

    pokemon_data[:height] = db.get_first_value("select height from pokemon_v2_pokemon where pokemon_species_id = #{pokemon_id};").to_f

    db.execute("select ps2.name from pokemon_v2_pokemonspecies ps2 join pokemon_v2_pokemonspecies ps on ps2.evolution_chain_id = ps.evolution_chain_id join pokemon_v2_pokemon p on p.name = ps.name where p.pokemon_species_id = #{pokemon_id};").each do |form|
     pokemon_data[:evolutions] << form.first.to_s unless form.first.to_s.capitalize == pokemon_data[:name]
    end

    return pokemon_data
end

def damage_taken(types)
    db = SQLite3::Database.new "db.sqlite3"
    pokemon_damage_taken = []

    if types.size == 1 then
         pokemon_damage_taken = db.execute("select damage_type_id, case when count(*) = 1 then max(damage_factor) when min(damage_factor) = 0 then 0 else round((min(damage_factor) * max(damage_factor)) / 100.0) end as combined_damage_factor from pokemon_v2_typeefficacy where target_type_id in (#{types[0].first}) group by damage_type_id order by damage_type_id asc;")
    else
         pokemon_damage_taken = db.execute("select damage_type_id, case when count(*) = 1 then max(damage_factor) when min(damage_factor) = 0 then 0 else round((min(damage_factor) * max(damage_factor)) / 100.0) end as combined_damage_factor from pokemon_v2_typeefficacy where target_type_id in (#{types[0].first}, #{types[1].first}) group by damage_type_id order by damage_type_id asc;")
    end

    return pokemon_damage_taken
end

def search_for_pokemon(query)
    db = SQLite3::Database.new "db.sqlite3"
    search_results = ""
    pokemon_names = db.execute("select name from pokemon_v2_pokemon;")
    matches = FuzzyMatch.new(pokemon_names, :find_all_with_score =>true).find(query)

    matches.each do |key,value|
      puts "Pokemon: #{key}"
      puts "Score: #{value}"

      pokemon_id = db.execute("select pokemon_species_id from pokemon_v2_pokemon where name = '#{key.first.to_s}';").first.first.to_s
      pokemon_sprite = JSON.parse(db.execute("select sprites from pokemon_v2_pokemonsprites where pokemon_id = #{pokemon_id};").first.first.to_s)["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
      puts pokemon_sprite

      search_results << "<a href='/show/#{pokemon_id}'><img src='#{pokemon_sprite}'/><br/>#{key.first.to_s.capitalize}<br/></a>" if value >= 0.25
    end

    return search_results
end


def validate_input_data()
end
