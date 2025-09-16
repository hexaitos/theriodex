def get_localised_text(lang, string)
	unless LOCALISED_TEXT[string][lang]
		LOCALISED_TEXT[string]["en"]
	else
		LOCALISED_TEXT[string][lang]
	end
end
