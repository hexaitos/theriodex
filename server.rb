require 'sinatra'
require 'csv'
require 'uri'
require 'net/http'
require 'json'
require 'sqlite3'
require_relative 'funcs.rb'

get "/" do
    selected_pokemon = rand(1..1024)
    pokemon_moves = ""

    db = SQLite3::Database.new "db.sqlite3"

    pokemon_name = db.execute("select name from pokemon_v2_pokemon where pokemon_species_id = #{selected_pokemon};").first.first.to_s.capitalize
    pokemon_sprite = JSON.parse(db.execute("select sprites from pokemon_v2_pokemonsprites where pokemon_id = #{selected_pokemon};").first.first.to_s)["front_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
    begin
        pokemon_sprite_back = JSON.parse(db.execute("select sprites from pokemon_v2_pokemonsprites where pokemon_id = #{selected_pokemon};").first.first.to_s)["back_default"].gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "")
    rescue NoMethodError
      pokemon_sprite_back = nil
    end
    db.execute("select name from pokemon_v2_movename where language_id = 9 and move_id in (select distinct move_id from pokemon_v2_pokemonmove where pokemon_id = #{selected_pokemon});").each do | move |
      pokemon_moves << "#{move.first.to_s}<br/>"
    end

    if pokemon_sprite_back == nil then
      puts "OWLIE"
    end

    erb :index, locals: {:sprite => pokemon_sprite, :name => pokemon_name, :moves => pokemon_moves, :sprite_back => pokemon_sprite_back}
end
