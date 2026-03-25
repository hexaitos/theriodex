get "/?:lang?/about" do
	lang = resolve_lang
	erb :about, locals: { text: markdown(:about), lang: lang }
end
