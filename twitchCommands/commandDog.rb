$command = {
    "name" => "random",
    "isPrivate?" => false,
    "alias" => "dog randdog",
    "lastUsed" => "randdog",
    "coolDown" => 15,
    "method" => -> (params) {
      response = Net::HTTP.get_response(URI.parse("https://api.thedogapi.com/v1/images/search"))
  
      unless response.code == '200'
        return "Error! couldn't fetch API"
      end
  
      data = JSON.parse(response.body)
      return "Random cat picture: #{data[0]["url"]}"
    }
  }