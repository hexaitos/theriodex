def check_pokemon_guess(guess)
	data = {}
	data[:pokemon_info] = session[:pokemon_info]
	data[:guess] = Sanitize.fragment(params['guess'])

	if DidYouMean::Levenshtein.distance(session[:pokemon_info][:name].downcase.gsub(' ', ''), data[:guess].downcase.gsub(' ', '')) <= 1 then
		data[:correct] = true
		session[:points] += 1
	elsif !data[:guess] or data[:guess] == ''
		data[:correct] = false
		data[:guess] = "nothing"
	else
		data[:correct] = false
	end

	session[:guesses] += 1
	return data
end