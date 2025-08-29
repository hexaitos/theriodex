require 'sinatra'
require 'sinatra/namespace'
require 'csv'
require 'json'
require 'sqlite3'
require 'fuzzy_match'
require 'sanitize'
require 'rack/cache'

require_relative 'lib/db_queries.rb'
require_relative 'lib/format_names.rb'
require_relative 'lib/views.rb'
require_relative 'lib/vars.rb'

require_relative 'lib/helpers/partials.rb'

set :static_cache_control, [:public, max_age: 3600]
use Rack::Cache,
	:metastore => 'file:/tmp/cache/rack/meta',
	:entitystore => 'file:/tmp/cache/rack/body',
	:verbose => true

get "/" do
	random_pokemon = rand(1..1024)
	
	erb :index, locals: pokemon_view_index(random_pokemon, params[:form], params[:s], params[:animated], LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en")
end

namespace "/show" do
	get "/moves/:id" do
		erb :moves, locals: pokemon_view_moves(params[:id])
	end

	get  "/ability/:id" do
		erb :ability, locals: pokemon_view_ability(params[:id])
	end

	get "/:id" do
		erb :index, locals: pokemon_view_index(params[:id], params[:form], params[:s], params[:animated], LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en")
	end
end

get "/search" do
	cache_control :public, :max_age => 3600
	search_results = search_for_pokemon(params[:q])

	erb :search, locals: {:search_results => search_results}
end

get "/about" do
	erb :about
end

get "/privacy" do
	erb :privacy
end

not_found do 
	status 404
	erb :error_404, layout: :error_layout
end

error 500 do
	status 500
	erb :error_500, layout: :error_layout
end