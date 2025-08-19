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
                         :types => pokemon_data[:types],
                         :flavour_text => pokemon_data[:flavour_text]
                        }
end

get "/show/:id" do
    puts pokemon_data = get_pokemon_info(Sanitize.fragment(params["id"])
)

    erb :index, locals: {
                         :sprite => pokemon_data[:sprite],
                         :name => pokemon_data[:name],
                         :sprite_back => pokemon_data[:sprite_back],
                         :types => pokemon_data[:types],
                         :flavour_text => pokemon_data[:flavour_text]
                        }
end

get "/search" do
    search_results = search_for_pokemon(Sanitize.fragment(params[:q]))

    erb :search, locals: {:search_results => search_results}
end

get "/about" do
    erb :about
end

get "/test" do
end
