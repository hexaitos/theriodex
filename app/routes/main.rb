get "/" do
	random_pokemon = rand(1..1024)
	puts lang =  LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

	erb :index, locals: pokemon_view_index(random_pokemon, params[:form], params[:s], params[:animated], lang)
end
