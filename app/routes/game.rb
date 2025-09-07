get "/game" do
	random_pokemon = rand(1..1024)
	pokemon_info = pokemon_view_index(random_pokemon)
	session[:name] = pokemon_info[:name]

	erb :game, locals: pokemon_view_index(random_pokemon)
end

post "/game/guess" do
	puts session[:name].downcase
	puts params['guess'].downcase
	if session[:name].downcase == params['guess'].downcase then
		'GOOD'
	else
		'BAD'
	end
end