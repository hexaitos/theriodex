namespace "/game" do
	get "" do
		lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? params[:lang] : "en"

		erb :"game/game_start", locals: { lang: lang, id: 1 }
	end

	post "/start/:lang/?:gen?" do
		start_game(params["diff"], params["gen"], params["username-1"], params["username-2"], params["username-3"], params["lang"])
	end

	get "/play" do
		lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"
		if !session[:difficulty]
			redirect "/game?lang=#{LANGUAGE_CODES.key(lang)}"
		end

		erb :"game/game", locals: pokemon_view_game(get_random_game_pokemon(session[:gen].clean), lang, session[:difficulty].clean)
	end

	post "/play" do
		erb :"game/guess", locals: check_pokemon_guess(params["guess"])
	end

	get "/results" do
		if !session[:results]
			redirect back
		end
		erb :"game/game_results", locals: pokemon_view_results()
	end

	get "/save" do
		download_results()
	end

	get "/reset/?:lang?" do
		session.clear
		redirect "/game?lang=#{params["lang"]}"
	end

	get "/skip/:lang" do
		session[:skips] = session[:skips] ? session[:skips] + 1 : 1
		session[:results][session[:pokemon_info][:id]] = { name: session[:pokemon_info][:name], skipped: true }
		redirect "/game/play?lang=#{params["lang"]}"
	end

	post "/leaderboard/save" do
		redirect back if params["privacy_accepted"].to_i != 1
		save_data_in_leaderboard(session[:username].clean) if session[:username]
		redirect back
	end

	get "/leaderboard/view" do
		lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"
		erb :"game/leaderboard", locals: { points: session[:points], guesses: session[:guesses], skips: session[:skips], username: session[:username], lang: LANGUAGE_CODES.key(lang) }
	end
end
