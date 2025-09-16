def check_pokemon_guess(guess)
	data = {}
	data[:pokemon_info] = session[:pokemon_info]
	data[:guess] = Sanitize.fragment(params["guess"])

	if DidYouMean::Levenshtein.distance(session[:pokemon_info][:name].downcase.gsub(" ", ""), data[:guess].downcase.gsub(" ", "")) <= 1 then
		data[:correct] = true
		session[:points] += 1
		session[:results][data[:pokemon_info][:id]] = { name: session[:pokemon_info][:name], guess: data[:guess], correct: true }

	elsif !data[:guess] or data[:guess] == ""
		data[:correct] = false
		data[:guess] = "nothing"

	else
		session[:results][data[:pokemon_info][:id]] = { name: session[:pokemon_info][:name], guess: data[:guess], correct: false }
		data[:correct] = false
	end

	session[:guesses] += 1
	data
end
