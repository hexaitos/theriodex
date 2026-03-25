get "/toggle-table/:id" do
	if !session[:table] then
		session[:table] = true
	else
		session[:table] = false
	end

	redirect "/show/pokemon/#{params['id']}"
end
