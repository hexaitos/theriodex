def generate_serial(points)
	value = points.to_f / 2 * 28 / 4 * 3
	puts value

	value = "#{value}%#{rand(0..200)}%#{points % 22}"

	Base64.encode64(value)
end
