get "/game" do
	lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? params[:lang] : "en"

	erb :'game/game_start', locals: { :lang => lang, :id => 1 }
end

post "/game/start/:lang/?:gen?" do
	session.clear
	session[:difficulty] ||= params['diff'].clean
	session[:gen] ||= params['gen'].clean if params['gen']
	session[:username] ||= generate_username(params['username-1'].clean, params['username-2'].clean, params['username-3'].clean)
	redirect "/game/play?lang=#{params['lang'].clean}"
end

get "/game/play" do
	lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"
	if !session[:difficulty] then
		redirect "/game?lang=#{LANGUAGE_CODES.key(lang)}"
	end
	
	erb :'game/game', locals: pokemon_view_game(get_random_game_pokemon(session[:gen].clean), lang, session[:difficulty].clean)
end

post "/game/play" do
	erb :'game/guess', locals: check_pokemon_guess(params['guess'])
end

get "/game/results" do
	if !session[:results] then
		redirect back
	end
	erb :'game/game_results', locals: pokemon_view_results()
end

get "/game/save" do
	download_results()
end

get "/game/reset/:lang" do
	session.clear
	redirect "/game?lang=#{params['lang']}"
end

get "/game/skip/:lang" do
	if !session[:skips] then session[:skips] = 1 else session[:skips] += 1 end
	session[:results][session[:pokemon_info][:id]] = { :name => session[:pokemon_info][:name], :skipped => true }
	redirect "/game/play?lang=#{params['lang']}"
end

post "/game/leaderboard/save" do
	save_data_in_leaderboard(session[:username].clean) if session[:username]
	redirect back
end

get "/game/leaderboard/view" do
	erb :'game/leaderboard', locals: { :points => session[:points], :guesses => session[:guesses], :skips => session[:skips], :username => session[:username], :lang => "en" }
end