get "/settings" do
	erb :settings
end

post "/settings/select-font" do
	session[:font] = params["font"]
	redirect back
end

get "/settings/test" do
	puts Dir.children("#{Dir.pwd}/public/css/fonts").map { |e| e.gsub(".css", "") }
end
