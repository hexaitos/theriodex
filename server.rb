require 'sinatra'
require 'sinatra/namespace'
require 'csv'
require 'json'
require 'sqlite3'
require 'fuzzy_match'
require 'sanitize'
require 'rack/cache'
require_relative 'funcs.rb'

set :static_cache_control, [:public, max_age: 36000]
use Rack::Cache,
	:metastore   => 'file:/tmp/cache/rack/meta',
	:entitystore => 'file:/tmp/cache/rack/body',
	:verbose => true

get "/" do
	random_pokemon = rand(1..1024)

	erb :index, locals: pokemon_view_index(random_pokemon, params[:form], params[:s], params[:animated])
end

namespace "/show" do
	get "/moves/:id" do
		erb :moves, locals: pokemon_view_moves(params[:id])
	end

	get "/:id" do
		erb :index, locals: pokemon_view_index(params["id"], params[:form], params[:s], params[:animated])
	end
end

get "/search" do
	cache_control :public, :max_age => 36000
	search_results = search_for_pokemon(params[:q])

	erb :search, locals: {:search_results => search_results}
end

get "/about" do
	erb :about
end