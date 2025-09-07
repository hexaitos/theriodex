get "/game" do
	random_pokemon = rand(1..1024)
	pokemon_info = pokemon_view_index(random_pokemon)
	session[:pokemon_info] = pokemon_info
	session[:points] ||= 0
	pokemon_info[:points] = session[:points]

	erb :game, locals: pokemon_info
end

post "/game" do
	if session[:pokemon_info][:name].downcase == params['guess'].downcase then
		correct = true
		session[:points] += 1
	else
		correct = false
	end

	erb :guess, locals: { :pokemon_info => session[:pokemon_info], :guess => params['guess'], :correct => correct }
end

get "/game/reset" do
	session.clear
	redirect "/game"
end