get "/:lang?/search" do
	lang = resolve_lang
	erb :search, locals: pokemon_view_search(params[:q], lang)
end
