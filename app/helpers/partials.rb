helpers do
	def partial(name, locals = {})
		erb :"partials/#{name}", layout: false, locals: locals
	end

	def pokemon_sprite_url(entry)
	begin
		sprites = JSON.parse(entry["sprites"] || "{}")

		url = sprites.dig("versions", entry["gen_db"], entry["version_db"], "front_transparent") ||
		sprites.dig("versions", entry["gen_db"], entry["version_db"], "front_default") ||
		sprites["front_default"]

		url&.gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") || ""
	rescue
		""
	end
end
end
