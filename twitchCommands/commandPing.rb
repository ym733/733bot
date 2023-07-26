require 'net/http'
require 'uri'

def ping (host)
  url = URI.parse(host)
  start_time = Time.now
  response = Net::HTTP.get(url)
  end_time = Time.now - start_time

  if response==""
    return "failed to receive ping"
  else
    return (end_time * 1000).to_i
  end
end

def commandping (user)
  return "@#{user}, PONG! twitch latency: #{ping "https://www.twitch.tv"}ms"
end