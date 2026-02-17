class String
	def titleise
		self.split(/ |\_/).map(&:capitalize).join(" ")
	end
end
