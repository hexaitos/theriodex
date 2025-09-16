def download_results
	# TODO re-write this some
	results = session[:results].dup

	results[:game_info] = {
		points: session[:points],
		guesses: session[:guesses],
		guesses: session[:skips],
		difficulty: session[:difficulty]
	}

	entry_keys = results.keys.reject { |k| k.to_s == "game_info" }
	entry_keys = entry_keys.sort_by { |k| k.to_i }

	lines = entry_keys.flat_map do |id|
		info = results[id]

		name = info[:name] || info["name"]
		skipped = info[:skipped] || info["skipped"]
		guess = info[:guess] || info["guess"]
		correct = info.key?(:correct) ? info[:correct] : info["correct"]

		if skipped
		"#{id}: #{name} (skipped)"
		elsif !guess.nil?
		status = correct ? "correct" : "incorrect"
		"#{id}: #{name} (guess: #{guess.inspect}, #{status})"
		else
		"#{id}: #{name} (no guess/skipped info)"
		end
	end

	if results.key?(:game_info) || results.key?("game_info")
		info = results[:game_info] || results["game_info"]
		lines << ""
		lines << "Game info:"
		info.each { |k, v| lines << " #{k}: #{v}" }
	end

	text = lines.join("\n")

	content_type "text/plain", charset: "utf-8"
	attachment "guesses-#{Time.now.strftime('%Y%m%d-%H%M%S')}.txt"
	body text
end
