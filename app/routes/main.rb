get "/" do
	random_pokemon = rand(1..1024)
	lang =  LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

	erb :index, layout: :index_layout, locals: view_pokemon(random_pokemon, params[:form], params[:s], params[:animated], lang)
end

get "/reset_session" do
	session.clear
	redirect back
end
