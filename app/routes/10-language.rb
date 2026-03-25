post "/change-lang" do
	new_lang = params[:lang]

	halt 400, "Invalid language" unless LANGUAGE_CODES.keys.include?(new_lang)

	uri = URI.parse(back)
	segments = uri.path.split("/").reject(&:empty?)

	if LANGUAGE_CODES.keys.include?(segments.first)
		segments[0] = new_lang
	else
		segments.unshift(new_lang)
	end

	uri.path = "/" + segments.join("/")
	redirect uri.to_s
end
