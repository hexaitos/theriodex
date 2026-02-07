def convert_damage(damage)
	if damage.to_f / 100 == 0.5 then
		 converted_damage = "<sup>1</sup>&frasl;<sub>2</sub>"
	elsif damage.to_f / 100 == 0.25 then
		 converted_damage = "<sup>1</sup>&frasl;<sub>4</sub>"
	else
		converted_damage = damage.to_f / 100
		converted_damage = converted_damage.to_s.gsub(/(\.)0+$/, "")
	end

	converted_damage
end
