require 'httparty'

class IsLive
  include HTTParty
  base_uri "https://decapi.me/"

  def initialize(channel)
    @channel = channel
  end

  def game
    self.class.get("/twitch/game/#{@channel}")
  end
  def uptime
    self.class.get("/twitch/uptime/#{@channel}")
  end
  def views
    self.class.get("/twitch/viewercount/#{@channel}")
  end
end

def commandIslive (channelorg, user, message)
    channel = message.split[1]
  if channel == nil
    channel = channelorg
  end

  begin
    streamer = IsLive.new(channel)
    game = streamer.game
    uptime = streamer.uptime
    views = streamer.views
  rescue
    return "Error! couldn't fetch API"
  end

  if uptime.include? "offline"
    return "@#{user}, #{channel} is currently offline"
  else
    return "@#{user}, #{channel} has been streaming #{game} for #{uptime} to #{views} viewers "
  end
end