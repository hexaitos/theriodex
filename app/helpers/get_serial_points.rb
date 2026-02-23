def get_serial_points(serial)
	SERIALS.transaction(true) do
		SERIALS[:valid][serial][:points]
	end
end
