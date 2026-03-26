get "/?:lang?/random" do
	random_pokemon = ALL_POKEMON_IDS.sample
	lang = resolve_lang

	erb :random, locals: view_pokemon(random_pokemon, params[:form], params[:s], params[:animated], lang)
end


get "/?:lang?/random/json" do
	random_pokemon = ALL_POKEMON_IDS.sample
	lang = resolve_lang
	view_pokemon(random_pokemon, params[:form], params[:s], params[:animated], lang).to_json
end

get "/:id/json" do
	lang = resolve_lang
	view_pokemon(params[:id], params[:form], params[:s], params[:animated], lang).to_json
end
