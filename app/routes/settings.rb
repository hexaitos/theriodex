get "/settings" do
	erb :settings
end

post "/settings/select-font" do
	session[:font] = params["font"]
	redirect back
end
