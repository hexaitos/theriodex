get "/?:lang?/contact" do
	lang = resolve_lang
	erb :contact, locals: { text: markdown(:contact) }
end
