def save_as_csv(hashes)
	column_names = hashes.first.keys
	s=CSV.generate do |csv|
	csv << column_names
	hashes.each do |x|
		csv << x.values
	end
end
File.write('the_file.csv', s)
end