$command = {
  "name" => "islive",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "islive uptime live",
  "lastUsed" => "Live",
  "coolDown" => 15,
  "method" => -> (params) {
    def format_time_diff(time_diff)
      hours = ((time_diff % (24 * 60 * 60)) / (60 * 60)).to_i
      minutes = ((time_diff % (60 * 60)) / 60).to_i
      seconds = (time_diff % 60).to_i

      formatted_time_diff = []

      formatted_time_diff << "#{hours} hour#{hours > 1 ? 's' : ''}" if hours > 0
      formatted_time_diff << "#{minutes} minute#{minutes > 1 ? 's' : ''}" if minutes > 0
      formatted_time_diff << "#{seconds} second#{seconds > 1 ? 's' : ''}" if seconds > 0

      formatted_time_diff.join(', ')
    end

    original_channel = params[:channel]
    parameters = params[:parameters]

    if parameters.nil?
      if original_channel.nil?
        return "error, no input!"
      end
      channel = original_channel
    else
      channel = parameters[0]
    end

    begin
      TwitchAPI.check_app_token

      obj = TwitchAPI.get_stream(channel)
      if obj.code != "200"
        puts "Not 200".colorize :red
        throw Exception.new "Not 200"
      end
      obj = JSON.parse obj.body
    rescue
      return "Error! couldn't fetch API"
    end

    obj = obj["data"]

    if obj.length == 0
      "#{channel} is currently offline"
    else
      obj = obj[0]
      game = obj["game_name"]
      views = obj["viewer_count"]
      uptime = format_time_diff(Time.now - Time.parse(obj["started_at"]))

      return "#{channel} has been streaming #{game} for #{uptime} to #{views} viewers "
    end
  }
}