helpers do
	def resolve_lang
		if params[:lang] && !LANGUAGE_CODES.has_key?(params[:lang].to_s.downcase)
			pass
		end

		LANGUAGE_CODES[params[:lang]&.downcase] || "en"
	end
end
