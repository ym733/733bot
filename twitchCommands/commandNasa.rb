$command = {
  "name" => "nasa",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "nasa",
  "lastUsed" => "Nasa",
  "coolDown" => 5,
  "method" => -> (params) {
    begin
      api_url = "https://api.nasa.gov/planetary/apod?api_key=#{$data["nasa_key"]}"
      response = HTTPS.get api_url

      obj = JSON.parse(response)
    rescue
      return "Error! couldn't fetch API"
    end

    artist = (obj["copyright"].include? "\n") ? "unknown" : obj["copyright"]
    url = obj["url"]
    title = obj["title"]

    return "Today's picture by #{artist}, Titled: #{title}  #{url}"
  }
}