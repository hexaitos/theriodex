get "/?:lang?/browse" do
	lang = resolve_lang
	erb :browse, locals: pokemon_view_browse(lang)
end
