def start_game(difficulty, gen = nil, u1, u2, u3, lang)
	session.clear
	session[:difficulty] ||= difficulty.clean
	session[:gen] ||= gen.clean if gen
	session[:username] ||= generate_username(u1.clean, u2.clean, u3.clean)
	redirect "/game/play?lang=#{lang.clean}"
end
