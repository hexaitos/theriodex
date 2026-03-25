get "/?:lang?/contact" do
	with_valid_lang do | lang |
		erb :contact, locals: { text: markdown(:contact) }
	end
end
