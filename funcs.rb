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

    return pokemon_data
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
