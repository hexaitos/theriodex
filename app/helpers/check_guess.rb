def check_pokemon_guess(guess)
	data = {}
	data[:pokemon_info] = session[:pokemon_info]
	data[:guess] = Sanitize.fragment(params['guess'])

	if session[:pokemon_info][:name].downcase.gsub(' ', '') == data[:guess].downcase.gsub(' ', '') then
		data[:correct] = true
		session[:points] += 1
	elsif !data[:guess] or data[:guess] == ''
		data[:correct] = false
		data[:guess] = "nothing"
	else
		data[:correct] = false
	end

	return data
end