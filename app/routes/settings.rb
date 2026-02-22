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

post "/settings/select-theme" do
	if THEMES.include?(params["theme"]) then
		session[:theme] = params["theme"]
	end

	puts session[:theme]

	redirect back
end

post "/settings/select-cursor" do
	if params["cursor"] != "none" then
		session[:cursor] = params["cursor"]
	else
		session[:cursor] = nil
	end

	redirect back
end

get "/settings/test" do
	puts is_theme_unlocked?("legendary.css")
end
