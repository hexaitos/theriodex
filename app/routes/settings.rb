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
	session[:all_themes_unlocked] = true
	puts generate_serial(10)
end

get "/settings/unlock/:serial" do
	session[:unlocked_themes] ||= []

	if is_serial_valid?(params[:serial]) then
		serial_points = get_serial_points(params[:serial])
		LOCKED_THEMES.each do | theme, points |
			session[:unlocked_themes].push(theme) if (serial_points >= points) and (!session[:unlocked_themes].include?(theme))
		end
	end

	redirect "/settings"
end
