require 'httparty'

def commandNasa (user, message)
  begin
    api_url = "https://api.nasa.gov/planetary/apod?api_key=#{$data["nasa_key"]}"
    # you can get a NASA API key and explore other APIs here: https://api.nasa.gov/
    response = Net::HTTP.get(URI(api_url))

    arr = JSON.parse(response)
  rescue
    return "Error! couldn't fetch API"
  end
    
  artist = arr["copyright"]
  url = arr["hdurl"]
  title = arr["title"]
  
  return "@#{user}, Today's picture by #{artist}, Titled: #{title}  #{url}"
end