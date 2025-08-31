get "/search" do
	cache_control :public, :max_age => 3600
	lang =  LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase) ? LANGUAGE_CODES[params[:lang].to_s.downcase] : "en"

	search_results = search_for_pokemon(params[:q], lang)

	erb :search, locals: {:search_results => search_results, :lang => LANGUAGE_CODES.key(lang)}
end