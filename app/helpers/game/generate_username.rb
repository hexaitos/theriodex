def generate_username(letter1, letter2, letter3)
	username = "#{letter1}#{letter2}#{letter3}".clean
	if !letter1.length == 1 or !letter2.length == 1 or !letter3.length == 1
		redirect "/game"
	elsif !username.match "[A-Z][A-Z][A-Z]" then
		redirect "/game"
	end

	username
end
