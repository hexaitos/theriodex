not_found do
	status 404
	erb :error_404, layout: :error_layout
end

error 500 do
	status 500
	erb :error_500, layout: :error_layout
end
