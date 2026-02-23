def init_serials()
	new_serial = "youdon'tdeserveit"
	points = 9999999999

	SERIALS.transaction do
		SERIALS[:valid] ||= {}
		SERIALS[:valid][new_serial] = { points: points }
	end

	new_serial
end
