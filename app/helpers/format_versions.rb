def format_versions(versions)
	formatted_versions = ""

	versions.split("~").each_with_index do | version, i|
		unless i == versions.split(",").size - 1
			formatted_versions << "#{version} • "
		else
			formatted_versions << "#{version}"
		end
	end

	formatted_versions
end
