def is_serial_valid?(value)
	if !THEME_PASSWORDS.key?(value) then
		decoded_value = Base64.decode64(value.to_s)

		points = decoded_value.partition("%").first.to_f * 2 / 21
		modulo = decoded_value.rpartition("%").last.to_f

		if (points % 22 == modulo) and (points != 0) then
			points.to_i
		else
			false
		end
	else
		THEME_PASSWORDS[value]
	end
end
