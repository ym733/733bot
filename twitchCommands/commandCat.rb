require 'httparty'

def commandcat (user, message)
    begin
      api_url = 'https://aws.random.cat/meow'
      response = Net::HTTP.get(URI(api_url))

      pic = JSON.parse(response)
    rescue
      return "Error! couldn't fetch API"
    end
    
    return "@#{user}, Random cat picture: #{pic["file"]}"
end