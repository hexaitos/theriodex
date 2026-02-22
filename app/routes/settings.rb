get "/settings" do
	erb :settings
end

post "/settings/select-font" do
	if FONTS.include?(params["font"]) then
		session[:font] = params["font"]
	end

	redirect back
end

post "/settings/select-theme" do
	if THEMES.include?(params["theme"]) and is_theme_unlocked?(params["theme"]) then
		session[:theme] = params["theme"]
	end

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
	session[:theme] = "legendary.css"
end
