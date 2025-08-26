helpers do
	def partial(name, locals = {})
		erb :"partials/#{name}", layout: false, locals: locals
	end
end