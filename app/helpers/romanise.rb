# Thanks: https://tech.tulentsev.com/2014/02/kata-convert-numbers-to-roman-numerals/
class Integer
	def romanise
		number = self
		reductions = {
			1000 => 'M',
			900 => 'CM',

			500 => 'D',
			400 => 'CD',

			100 => 'C',
			90 => 'XC',

			50 => 'L',
			40 => 'XL',

			10 => 'X',
			9 => 'IX',

			5 => 'V',
			4 => 'IV',

			1 => 'I',
		}

		result = ''

		while number > 0
			reductions.each do |n, subst|
				if number / n >= 1 
					result << subst
					number -= n
					break
				end
			end
		end

		result
	end
end
