def is_theme_unlocked?(theme)
	if LOCKED_THEMES.include?(theme) then
		(session[:points].to_i >= LOCKED_THEMES[theme]) or (session[:unlocked_themes]&.include?(theme))
	else
		true
	end
end
