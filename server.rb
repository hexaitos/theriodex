require 'sinatra'
require 'csv'
require 'uri'
require 'net/http'
require 'json'

get "/" do
    puts selected_pokemon = rand(1..1024)

    uri = URI("http://localhost:8000/api/v2/pokemon/#{selected_pokemon}/")
    res = Net::HTTP.get_response(uri)
    res.body if res.is_a?(Net::HTTPSuccess)

    pokemon_json = JSON.parse(res.body)

    puts sprite = pokemon_json["sprites"]["front_default"]
    puts moves_json = pokemon_json["moves"]
    moves = ""

    moves_json.each do |key, value|
      moves << "#{key["move"]["name"]}\n"
    end

    "
    <img src='#{sprite}'/>
    <br/>
    <p>#{pokemon_json['name']}</p>
    <p>#{moves}</p>
    "
end
