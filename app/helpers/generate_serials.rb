def generate_serial(points)
	new_serial = SecureRandom.hex(6)

	SERIALS.transaction do
		SERIALS[:valid] ||= {}
		SERIALS[:valid][new_serial] = { points: points }
	end

	new_serial
end
