get "/settings" do
	erb :settings
end

post "/settings/select-font" do
	if FONTS.include?(params["font"]) then
		session[:font] = params["font"]
	end

	redirect back
end

post "/settings/toggle-shiny" do
	if params["shiny-toggle"] == "normal" then
		session[:shiny] = false
	else
		session[:shiny] = true
	end

	redirect back
end

get "/settings/test" do
	puts Dir.children("#{Dir.pwd}/public/css/fonts").map { |e| e.gsub(".css", "") }
end
