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

		session[:serial] ||= nil
		notification = ""

		LOCKED_THEMES.each do | theme, points |
			formatted_theme = File.basename(theme, ".*")
			if session[:points] and session[:points] >= points
				if !session[:serial] or (is_serial_valid?(session[:serial][:serial]) and get_serial_points(session[:serial][:serial]) < points) then
					session[:serial] = {}

					session[:serial][:serial] = generate_serial(points).gsub(" ", "")
					session[:serial][:theme] = formatted_theme
				end
			end


		end
		flash[:notification] = "You've unlocked the #{session[:serial][:theme]} theme! Go to the Settings to select it. Your code is <code class='serial'>#{session[:serial][:serial]}</code>" if session[:serial]

		erb :"game/game", locals: pokemon_view_game(get_random_game_pokemon(session[:gen].clean), lang, session[:difficulty].clean)
	end

	post "/play" do
		erb :"game/guess", locals: check_pokemon_guess(params["guess"])
	end

	get "/results" do
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

	get "/game/test" do
		puts session[:points]
	end
end
