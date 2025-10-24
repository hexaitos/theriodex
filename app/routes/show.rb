namespace "/show" do
	get "/moves/:id" do
		erb :moves, locals: pokemon_view_moves(params[:id])
	end

	get "/ability/:id" do
		lang =  LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

		erb :ability, locals: pokemon_view_ability(params[:id], lang)
	end

	get "/pokemon/gen/:gen" do
		lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

		erb :pokemon_by_gen, locals: pokemon_view_gen(params["gen"], lang)
	end

	get "/pokemon/type/:type" do
		lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

		erb :pokemon_by_type, locals: pokemon_view_type(params["type"], lang)
	end

	get "/items/:pocket/gen/:gen" do
		items = get_items_by_category(params["pocket"], 9, params["gen"])

		puts items

		erb :items_by_pocket, locals: { items: items }
	end

	get "/items/:pocket" do
		items = get_items_by_category(params["pocket"], 9, params["gen"])

		puts items

		erb :items_by_pocket, locals: { items: items }
	end

	get "/:id" do
		redirect "/show/pokemon/#{request.fullpath.gsub('/show/', '')}"
	end

	get "/pokemon/:id" do
		lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

		erb :index, locals: pokemon_view_index(params[:id], params[:form], params[:s], params[:animated], lang)
	end
end
