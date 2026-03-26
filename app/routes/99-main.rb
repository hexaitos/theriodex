get "/:lang?" do
	random_pokemon = ALL_POKEMON_IDS.sample
	lang =  resolve_lang

	erb :index, layout: :index_layout, locals: view_pokemon(random_pokemon, params[:form], params[:s], params[:animated], lang)
end

get "/reset_session" do
	session.clear
	redirect back
end
