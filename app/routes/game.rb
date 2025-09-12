get "/game" do
	lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? params[:lang] : "en"

	erb :'game/game_start', locals: { :lang => lang, :id => 1 }
end

post "/game/start/:lang/?:gen?" do
	session.clear
	session[:difficulty] ||= params['diff']
	session[:gen] ||= params['gen'] if params['gen']
	session[:username] ||= generate_username(params['username-1'], params['username-2'], params['username-3'])
	redirect "/game/play?lang=#{params['lang']}"
end

get "/game/play" do
	lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"
	if !session[:difficulty] then
		redirect "/game?lang=#{LANGUAGE_CODES.key(lang)}"
	end
	
	erb :'game/game', locals: pokemon_view_game(get_random_game_pokemon(session[:gen]), lang, session[:difficulty])
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
	save_data_in_leaderboard(session[:username]) if session[:username]
	redirect back
end

get "/game/leaderboard" do
	erb :'game/leaderboard'
end