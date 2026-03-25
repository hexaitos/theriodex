get "/:lang?" do
	random_pokemon = rand(1..1024)
	lang =  resolve_lang

	erb :index, layout: :index_layout, locals: view_pokemon(random_pokemon, params[:form], params[:s], params[:animated], lang)
end

get "reset_session" do
	session.clear
	redirect back
end
