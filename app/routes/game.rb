get "/game" do
	random_pokemon = rand(1..1024)
	lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"
	
	erb :game, locals: pokemon_view_game(random_pokemon, lang)
end

post "/game" do
	erb :guess, locals: check_pokemon_guess(params['guess'])
end

get "/game/reset/:lang" do
	session.clear
	redirect "/game?lang=#{params['lang']}"
end