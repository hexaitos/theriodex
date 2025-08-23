require 'sinatra'
require 'csv'
require 'json'
require 'sqlite3'
require 'fuzzy_match'
require 'sanitize'
require_relative 'funcs.rb'

get "/" do
	random_pokemon = rand(1..1024)
	pokemon_data = get_pokemon_info(random_pokemon)
	pokemon_damage = damage_taken(pokemon_data[:types])

	puts pokemon_data[:evolutions]

	erb :index, locals: {
						:sprite => pokemon_data[:sprite],
						:name => pokemon_data[:name],
						:id => random_pokemon,
						:sprite_back => pokemon_data[:sprite_back],
						:types => pokemon_data[:types],
						:flavour_text => pokemon_data[:flavour_text],
						:damage_taken => pokemon_damage,
						:species_name => pokemon_data[:species_name],
						:weight => pokemon_data[:weight],
						:height => pokemon_data[:height],
						:evolutions => pokemon_data[:evolutions]
						}
end

get "/show/:id" do
	selected_pokemon = Sanitize.fragment(params["id"])

	if selected_pokemon.is_integer? then
		begin
			pokemon_data = get_pokemon_info(selected_pokemon)
		rescue JSON::ParserError
			pokemon_data = get_pokemon_info(134)
		end
		pokemon_damage = damage_taken(pokemon_data[:types])
	else
		begin
			pokemon_data = get_pokemon_info_by_name(selected_pokemon)
		rescue JSON::ParserError
			pokemon_data = get_pokemon_info_by_name("vaporeon")
		end
		pokemon_damage = damage_taken(pokemon_data[:types])
		selected_pokemon = pokemon_data[:id]
	end

	puts pokemon_data[:name]

	erb :index, locals: {
						:sprite => pokemon_data[:sprite],
						:name => pokemon_data[:name],
						:id => selected_pokemon,
						:sprite_back => pokemon_data[:sprite_back],
						:types => pokemon_data[:types],
						:flavour_text => pokemon_data[:flavour_text],
						:damage_taken => pokemon_damage,
						:species_name => pokemon_data[:species_name],
						:weight => pokemon_data[:weight],
						:height => pokemon_data[:height],
						:evolutions => pokemon_data[:evolutions]
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
