def get_serial_points(value)
	if !THEME_PASSWORDS.key?(value) then
		decoded_value = Base64.decode64(value.to_s)

		points = decoded_value.partition("%").first.to_f * 2 / 21

		points.to_i
	else
		THEME_PASSWORDS[value]
	end
end
