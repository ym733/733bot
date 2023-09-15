require "uri"
require "net/http"
require 'json'
require 'time'

def timeSince(time_ran)

  string = ""

  hours = (time_ran / 3600) % 60
  minutes = (time_ran / 60 ) % 60
  seconds  = time_ran % 60

  string = (hours.to_i != 0)? string + "hour: #{hours.to_i}, " : string + ""
  string = (minutes.to_i != 0)? string + "minutes: #{minutes.to_i}, ": string + ""
  string = (minutes.to_i != 0)? string + "seconds: #{seconds.to_i}, " : string + ""

  string.strip
end

def getObj(channel)
  url = URI("https://api.twitch.tv/helix/streams?user_login=#{channel}")

  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["Client-id"] = $data["twitchAPI"]["client_id"]
  request["Authorization"] = "Bearer #{$data["twitchAPI"]["app_token"]}"

  response = https.request(request)
  JSON.parse response.body
end

def commandIslive (orgChannel, user, parameters)
  if parameters == nil
    channel = orgChannel
  else
    channel = parameters[0]
  end

  begin
    obj = getObj(channel)
    if obj["status"] == 401
      throw Exception.new "Unauthorized"
    end
  rescue
    return "Error! couldn't fetch API"
  end

  obj = obj["data"]

  if obj.length == 0
    "@#{user}, #{channel} is currently offline"
  else
    obj = obj[0]
    game = obj["game_name"]
    views = obj["viewer_count"]
    uptime = timeSince(Time.now - Time.parse(obj["started_at"]))

    return "@#{user}, #{channel} has been streaming #{game} for #{uptime} to #{views} viewers "
  end
end