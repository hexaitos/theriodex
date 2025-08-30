def get_localised_text(lang, string)
	unless LOCALISED_TEXT[string][lang]
		return LOCALISED_TEXT[string]["en"]
	else
		return LOCALISED_TEXT[string][lang]
	end
end