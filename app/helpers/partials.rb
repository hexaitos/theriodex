helpers do
	def partial(name, locals = {})
		erb :"partials/#{name}", layout: false, locals: locals
	end

	def pokemon_sprite_url(entry)
	begin
		sprites = JSON.parse(entry["sprites"] || "{}")

		url = sprites.dig("versions", entry["gen_db"], entry["version_db"], "front_transparent") ||
		sprites.dig("versions", entry["gen_db"], entry["version_db"], "front_default") ||
		sprites["other"]["official-artwork"]["front_default"]

		url&.gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") || ""
	rescue
		""
	end

	end

	def get_sprites_from_gen(sprite_hash, generation)
		sprites = []
		url = nil

		parsed_sprites = JSON.parse(sprite_hash)
		available_sprites = parsed_sprites.dig("versions", generation) || {}

		available_sprites.each do | version |
			url = version[1]["front_transparent"] || version[1]["front_default"] unless version[0] == "icons"

			url = parsed_sprites["other"]["official-artwork"]["front_default"] if version[0] == "icons" and !url

			sprites << url.gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") if url and !sprites.include?(url)
		end

		sprites << parsed_sprites["other"]["official-artwork"]["front_default"] if sprites.empty?

		sprites
	end
end
