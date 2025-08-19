require 'sinatra'
require 'csv'
require 'json'
require 'sqlite3'
require 'fuzzy_match'
require 'sanitize'
require_relative 'funcs.rb'

get "/" do
    puts pokemon_data = get_pokemon_info(rand(1..1025))

    erb :index, locals: {
                         :sprite => pokemon_data[:sprite],
                         :name => pokemon_data[:name],
                         :sprite_back => pokemon_data[:sprite_back],
                         :types => pokemon_data[:types]
                        }
end

get "/show/:id" do
    puts pokemon_data = get_pokemon_info(Sanitize.fragment(params["id"])
)

    erb :index, locals: {
                         :sprite => pokemon_data[:sprite],
                         :name => pokemon_data[:name],
                         :sprite_back => pokemon_data[:sprite_back],
                         :types => pokemon_data[:types]
                        }
end

get "/search" do
    query = params[:q]
    query = Sanitize.fragment(query)
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

    erb :search, locals: {:search_results => search_results}
end

get "/about" do
    erb :about
end

get "/test" do
end
