require 'sinatra'
require 'csv'
require 'json'
require 'sqlite3'
require 'fuzzy_match'
require 'sanitize'
require_relative 'funcs.rb'

get "/" do
	random_pokemon = rand(1..1024)

	erb :index, locals: pokemon_view_index(random_pokemon, params[:form], params[:s])
end

get "/show/:id" do
	erb :index, locals: pokemon_view_index(params["id"], params[:form], params[:s])
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
