def get_pokemon_data(host, pokemon)
    uri = URI("http://#{host}/api/v2/pokemon/#{pokemon}/")
    res = Net::HTTP.get_response(uri)
    return res.body if res.is_a?(Net::HTTPSuccess)
end

def parse_json_data(json)
end
