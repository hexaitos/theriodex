get "/" do
	random_pokemon = rand(1..1024)
	puts lang =  LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

	erb :index, locals: pokemon_view_index(random_pokemon, params[:form], params[:s], params[:animated], lang)
end

get "/random/json" do
	random_pokemon = rand(1..1024)
	puts lang =  LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

	pokemon_view_index(random_pokemon, params[:form], params[:s], params[:animated], lang).to_json
end

get "/:id/json" do
	lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

	pokemon_view_index(params[:id], params[:form], params[:s], params[:animated], lang).to_json
end

get "/reset_session" do
	session.clear
	redirect back
end
