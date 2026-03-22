def all_values_nil?(obj)
	case obj
	when Hash
		obj.values.all? { |v| all_values_nil?(v) }
	else
		obj.nil?
	end
end
