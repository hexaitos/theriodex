def is_serial_valid?(serial)
	SERIALS.transaction(true) do
		SERIALS[:valid].key?(serial)
	end
end
