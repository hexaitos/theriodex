namespace "/?:lang?/game" do
	get "" do
		lang = resolve_lang

		erb :"game/game_start", locals: { lang: lang, id: 1 }
	end

	post "/start/?:gen?" do
		puts lang = resolve_lang
		unless params["daily"] == "true"
			start_game(params["diff"], params["gen"], params["username-1"], params["username-2"], params["username-3"], params["lang"])
		else
			start_challenge(params["username-1"], params["username-2"], params["username-3"], params["lang"])
		end
	end

	get "/play" do
		lang = resolve_lang

		if !session[:difficulty]
			redirect "/#{LANGUAGE_CODES.key(lang)}/game"
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
		lang = resolve_lang

		erb :"game/guess", locals: check_pokemon_guess(params["guess"])
	end

	get "/challenge/play" do
		lang = resolve_lang
		redirect "/game/results" if session[:guesses] + session[:skips] == POKEMON_CHALLENGE_NUM

		erb :"game/game", locals: pokemon_view_game(get_pokemon_for_day[session[:guesses] + session[:skips]], lang, session[:difficulty].clean)
	end

	get "/results" do
		lang = resolve_lang

		erb :"game/game_results", locals: pokemon_view_results()
	end

	get "/save" do
		lang = resolve_lang

		download_results()
	end

	get "/reset" do
		clear_game
		redirect "/#{params["lang"]}/game"
	end

	get "/skip" do
		lang = resolve_lang

		session[:skips] = session[:skips] ? session[:skips] + 1 : 1
		session[:results][session[:pokemon_info][:id]] = { name: session[:pokemon_info][:name], skipped: true }

		redirect "/#{params["lang"]}/game/challenge/play" if session[:challenge]
		redirect "/#{params["lang"]}/game/play"
	end

	post "/leaderboard/save" do
		lang = resolve_lang

		redirect back if params["privacy_accepted"].to_i != 1
		save_data_in_leaderboard(session[:username].clean) if session[:username]
		redirect back
	end

	get "/leaderboard/view" do
		lang = resolve_lang

		erb :"game/leaderboard", locals: { points: session[:points], guesses: session[:guesses], skips: session[:skips], username: session[:username], lang: LANGUAGE_CODES.key(lang) }
	end

	get "/game/test" do
		puts session[:points]
	end
end
