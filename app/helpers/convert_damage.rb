def convert_damage(damage)
	if damage.to_f / 100 == 0.5 then
		 converted_damage = "½"
	elsif damage.to_f / 100 == 0.25 then
		 converted_damage = "¼"
	else
		converted_damage = damage.to_f / 100
		converted_damage = converted_damage.to_s.gsub(/(\.)0+$/, '')
	end

	converted_damage
end
