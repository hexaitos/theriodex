get "/" do
	random_pokemon = rand(1..1024)
	lang =  LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

	erb :index, layout: :index_layout, locals: view_pokemon(random_pokemon, params[:form], params[:s], params[:animated], lang)
end

get "/random" do
	random_pokemon = rand(1..1024)
	puts lang =  LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

	erb :random, locals: view_pokemon(random_pokemon, params[:form], params[:s], params[:animated], lang)
end

get "/random/json" do
	random_pokemon = rand(1..1024)
	puts lang =  LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

	view_pokemon(random_pokemon, params[:form], params[:s], params[:animated], lang).to_json
end

get "/:id/json" do
	lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

	view_pokemon(params[:id], params[:form], params[:s], params[:animated], lang).to_json
end

get "/reset_session" do
	session.clear
	redirect back
end
