get "/search" do
	cache_control :public, :max_age => 3600
	lang =  LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

	erb :search, locals: pokemon_view_search(params[:q], lang)
end