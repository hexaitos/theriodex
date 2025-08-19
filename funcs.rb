def get_pokemon_data(host, pokemon)
    uri = URI("http://#{host}/api/v2/pokemon/#{pokemon}/")
    res = Net::HTTP.get_response(uri)
    return res.body if res.is_a?(Net::HTTPSuccess)
end

def parse_json_data(json)
end

def get_pokemon_info(pokemon_id)
    pokemon_data = {}

    db = SQLite3::Database.new "db.sqlite3"

    pokemon_data[:name] = db.execute("select name from pokemon_v2_pokemon where pokemon_species_id = #{pokemon_id};").first.first.to_s.capitalize
    pokemon_data[:sprite] = JSON.parse(db.execute("select sprites from pokemon_v2_pokemonsprites where pokemon_id = #{pokemon_id};").first.first.to_s)["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
    begin
        pokemon_data[:sprite_back] = JSON.parse(db.execute("select sprites from pokemon_v2_pokemonsprites where pokemon_id = #{pokemon_id};").first.first.to_s)["back_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
    rescue NoMethodError
        pokemon_data[:sprite_back] = nil
    end

    pokemon_data[:types] = db.execute("select type_id from pokemon_v2_pokemontype where pokemon_id = #{pokemon_id};")

    pokemon_data[:flavour_text] = db.execute("select flavor_text from pokemon_v2_pokemonspeciesflavortext where pokemon_species_id = #{pokemon_id} and language_id = 9 order by random() limit 1;").first.first.to_s.gsub("", "")

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
    puts matches = FuzzyMatch.new(pokemon_names, :find_all_with_score =>true).find(query)

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
