helpers do
	def show_sprites(id, lang, sprite, sprite_back, back_shiny, back_female, back_shiny_female, animated_back, animated_back_shiny, front_shiny, front_female, front_shiny_female, animated_front, animated_front_shiny, sex, form, animated)
		lang = LANGUAGE_CODES.key(lang)

		has_shiny = !front_shiny.nil?
		has_female = !front_female.nil?
		has_female_shiny = !front_shiny_female.nil?
		has_animated = !animated_front.nil?
		has_animated_shiny = !animated_front_shiny.nil?

		showing_female = (sex == "female") && has_female
		showing_shiny = (form == "shiny") && has_shiny
		showing_animated = animated && has_animated

		sprite_type = if showing_female && showing_shiny
			:female_shiny
		elsif showing_female
			:female
		elsif showing_shiny && showing_animated
			:shiny_animated
		elsif showing_shiny
			:shiny
		elsif showing_animated
			:animated
		else
			:default
		end

		front_sprites = {
			default: sprite,
			shiny: front_shiny,
			female: front_female,
			female_shiny: front_shiny_female,
			animated: animated_front,
			shiny_animated: animated_front_shiny
		}

		back_sprites = {
			default: sprite_back,
			shiny: back_shiny,
			female: back_female,
			female_shiny: back_shiny_female,
			animated: animated_back,
			shiny_animated: animated_back_shiny
		}

		links = []

		if showing_shiny
			url = "/show/#{id}?lang=#{lang}"
			url += "&animated=true" if showing_animated
			links << { url: url, icon: "⚪", key: :normal }
		elsif has_shiny
			url = "/show/#{id}?form=shiny&lang=#{lang}"
			url += "&animated=true" if showing_animated
			links << { url: url, icon: "💫", key: :shiny }
		end

		if showing_female
			url = "/show/#{id}?lang=#{lang}"
			url += "&form=shiny" if showing_shiny
			links << { url: url, icon: "♂️", key: :male }
		elsif has_female
			url = "/show/#{id}?s=female&lang=#{lang}"
			url += "&form=shiny" if showing_shiny
			links << { url: url, icon: "♀️", key: :female }
		end

		if showing_animated
			url = "/show/#{id}?lang=#{lang}"
			url += "&form=shiny" if showing_shiny
			links << { url: url, icon: "⏯️", key: :toggle_animation }
		elsif has_animated
			url = "/show/#{id}?animated=true&lang=#{lang}"
			url += "&form=shiny" if showing_shiny
			links << { url: url, icon: "⏯️", key: :toggle_animation }
		end

		{
			front: front_sprites[sprite_type],
			back: back_sprites[sprite_type],
			links: links
		}
	end
end
