namespace "/show" do
	get "/pokemon/moves/:pokemon_id/gen/:gen_id" do
		lang =  LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

		erb :moves, locals: pokemon_view_moves(params[:pokemon_id], params[:gen_id], lang)
	end

	get "/move/:move_id/gen/:gen_id" do
		lang =  LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

		erb :move_details, locals: move_view_details_by_gen(params[:move_id], params[:gen_id], lang)
	end

	get "/pokemon/move/:move_id/gen/:gen_id" do
		lang =  LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

		erb :pokemon_by_moves, locals: pokemon_view_by_moves_and_gen(params[:move_id], params[:gen_id], lang)
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

	get "/pokemon/type/:type/gen/:gen" do
		lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

		erb :pokemon_by_type_gen, locals: pokemon_view_type(params["type"], lang, params["gen"])
	end

	post "/pokemon/type/gen" do
		redirect "/show/pokemon/type/#{params['type']}/gen/#{params['gen']}"
	end

	get "/items/:pocket/gen/:gen" do
		items = get_items_by_category(params["pocket"], 9, params["gen"])

		puts items

		erb :items_by_pocket, locals: { items: items }
	end

	get "/items/:pocket" do
		lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"


		erb :items_by_pocket, locals: pokemon_view_items_by_pocket(params["pocket"], lang)
	end

	get "/:id" do
		redirect "/show/pokemon/#{request.fullpath.gsub('/show/', '')}"
	end

	get "/pokemon/:id" do
		lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

		erb :index, locals: pokemon_view_index(params[:id], params[:form], params[:s], params[:animated], lang)
	end

	get "/test/test" do
		puts get_pokemon_base_form(10193)
	end
end
