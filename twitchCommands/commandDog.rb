$command = {
  "name" => "random",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "dog randdog",
  "lastUsed" => "randdog",
  "coolDown" => 15,
  "method" => -> (params) {
    api_url = "https://api.thedogapi.com/v1/images/search"
    response = HTTPS.get_response api_url

    unless response.code == '200'
      return "Error! couldn't fetch API"
    end

    data = JSON.parse(response.body)
    return "Random cat picture: #{data[0]["url"]}"
  }
}