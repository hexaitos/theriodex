get "/game" do
	random_pokemon = rand(1..1024)
	lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

	pokemon_info = pokemon_view_index(random_pokemon, nil, nil, nil, lang)
	session[:pokemon_info] = pokemon_info
	session[:points] ||= 0
	pokemon_info[:points] = session[:points]

	erb :game, locals: pokemon_info
end

post "/game" do
	guess = Sanitize.fragment(params['guess'])

	if session[:pokemon_info][:name].downcase == guess.downcase then
		correct = true
		session[:points] += 1
	elsif !guess or guess == ''
		correct = false
		guess = "nothing"
	else
		correct = false
	end

	erb :guess, locals: { :pokemon_info => session[:pokemon_info], :guess => guess, :correct => correct }
end

get "/game/reset/:lang" do
	session.clear
	redirect "/game?lang=#{params['lang']}"
end