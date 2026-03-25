get "/:lang?/privacy" do
	erb :privacy, locals: { text: markdown(:privacy) }
end
