get "/?:lang?/privacy" do
	lang = resolve_lang
	erb :privacy, locals: { text: markdown(:privacy) }
end
