get "/about" do
	erb :about, locals: { text: markdown(:about) }
end