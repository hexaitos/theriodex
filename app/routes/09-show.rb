namespace "/?:lang?/show" do
	get "/pokemon/moves/:pokemon_id/gen/:gen_id" do
		lang = resolve_lang
		erb :moves, locals: pokemon_view_moves(params[:pokemon_id], params[:gen_id], lang)
	end

	get "/move/:move_id/gen/:gen_id" do
		lang = resolve_lang
		erb :move_details, locals: move_view_details_by_gen(params[:move_id], params[:gen_id], lang)
	end

	get "/pokemon/move/:move_id/gen/:gen_id" do
		lang = resolve_lang
		erb :pokemon_by_moves, locals: pokemon_view_by_moves_and_gen(params[:move_id], params[:gen_id], lang)
	end

	get "/ability/:id" do
		lang = resolve_lang
		erb :ability, locals: pokemon_view_ability(params[:id], lang)
	end

	get "/pokemon/gen/:gen" do
		lang = resolve_lang
		erb :pokemon_by_gen, locals: pokemon_view_gen(params["gen"], lang)
	end

	get "/pokemon/type/:type" do
		lang = resolve_lang
		erb :pokemon_by_type, locals: pokemon_view_type(params["type"], lang)
	end

	get "/pokemon/type/:type/gen/:gen" do
		lang = resolve_lang
		erb :pokemon_by_type_gen, locals: pokemon_view_type(params["type"], lang, params["gen"])
	end

	post "/pokemon/type/gen" do
		redirect "/show/pokemon/type/#{params['type']}/gen/#{params['gen']}"
	end

	get "/items/:pocket/gen/:gen" do
		items = get_items_by_category(params["pocket"], 9, params["gen"])

		items

		erb :items_by_pocket, locals: { items: items }
	end

	get "/items/:pocket" do
		lang = resolve_lang

		erb :items_by_pocket, locals: pokemon_view_items_by_pocket(params["pocket"], lang)
	end

	get "/:id" do
		lang = resolve_lang
		redirect "/show/pokemon/#{params[:id]}" if !lang
		redirect "#{LANGUAGE_CODES.key(lang)}/show/pokemon/#{params[:id]}" if lang
	end

	get "/pokemon/:id" do
		lang = resolve_lang
		erb :random, locals: view_pokemon(params[:id], params[:form], params[:s], params[:animated], lang)
	end

	get "/sprites/:id" do
		erb :sprites, locals: { sprites: get_all_sprites(params[:id]), name: get_pokemon_name(params[:id]) }
	end

	get "/test/test" do
		puts get_pokemon_base_form(10193)
	end
end
