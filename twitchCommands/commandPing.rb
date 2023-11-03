$command = {
  "name" => "ping",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "ping pong",
  "lastUsed" => "Ping",
  "coolDown" => 15,
  "method" => -> (params) {
    def ping_server(host)
      start_time = Time.now
      response = HTTPS.get host
      end_time = Time.now - start_time

      if response==""
        return "failed to receive ping"
      else
        return (end_time * 1000).to_i
      end
    end

    def format_time_diff(time_diff)
      days = ((time_diff % (30 * 24 * 60 * 60)) / (24 * 60 * 60)).to_i
      hours = ((time_diff % (24 * 60 * 60)) / (60 * 60)).to_i
      minutes = ((time_diff % (60 * 60)) / 60).to_i
      seconds = (time_diff % 60).to_i

      formatted_time_diff = []

      formatted_time_diff << "#{days} day#{days > 1 ? 's' : ''}" if days > 0
      formatted_time_diff << "#{hours} hour#{hours > 1 ? 's' : ''}" if hours > 0
      formatted_time_diff << "#{minutes} minute#{minutes > 1 ? 's' : ''}" if minutes > 0
      formatted_time_diff << "#{seconds} second#{seconds > 1 ? 's' : ''}" if seconds > 0

      formatted_time_diff.join(', ')
    end

    return "PONG! Time running: #{format_time_diff(Time.now - params[:irc].time_started)}" + " twitch latency: #{ping_server "https://www.twitch.tv"}ms"
  }
}