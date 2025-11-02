def get_random_sprite_from_gen(sprite_hash, generation)
	sprites = []
	url = nil

	generation = generation.gsub(/\s+/, '-').downcase if generation.include?(" ")

	parsed_sprites = JSON.parse(sprite_hash)
	available_sprites = parsed_sprites.dig("versions", generation) || {}

	available_sprites.each do | version |
		url = version[1]["front_transparent"] || version[1]["front_default"] unless version[0] == "icons"

		url = parsed_sprites["other"]["official-artwork"]["front_default"] if version[0] == "icons" and !url

		sprites << url.gsub("https://raw.githubusercontent.com/PokeAPI/sprites/master", "") if url and !sprites.include?(url)
	end

	sprites << parsed_sprites["other"]["official-artwork"]["front_default"] if sprites.empty?

	sprites[rand(sprites.size - 1)]
end
