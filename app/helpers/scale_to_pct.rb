def scale_to_pct(value, min_val: 40, max_val: 250, min_pct: 20, max_pct: 100)
	min_pct + (value - min_val).to_f / (max_val - min_val) * (max_pct - min_pct)
end

def hue_for_pct(pct)
	hue = (pct / 100.0) ** 0.6 * 120
	"hsl(#{hue.round}, 70%, 50%)"
end
