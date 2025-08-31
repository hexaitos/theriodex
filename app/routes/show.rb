namespace "/show" do
	get "/moves/:id" do
		erb :moves, locals: pokemon_view_moves(params[:id])
	end

	get  "/ability/:id" do
		lang =  LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"
		
		erb :ability, locals: pokemon_view_ability(params[:id], lang)
	end

	get "/:id" do
		lang = LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

		erb :index, locals: pokemon_view_index(params[:id], params[:form], params[:s], params[:animated], lang)
	end
end
