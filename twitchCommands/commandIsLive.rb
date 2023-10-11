$command = {
  "name" => "islive",
  "isPrivate?" => false,
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

    def get_object(channel)
      url = URI("https://api.twitch.tv/helix/streams?user_login=#{channel}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Client-id"] = $data["twitchAPI"]["client_id"]
      request["Authorization"] = "Bearer #{$data["twitchAPI"]["app_token"]}"

      response = https.request(request)
      JSON.parse response.body
    end

    user = params[:user]
    original_channel = params[:channel]
    parameters = params[:parameters]

    if parameters.nil?
      channel = original_channel
    else
      channel = parameters[0]
    end

    begin
      obj = get_object(channel)
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
      uptime = format_time_diff(Time.now - Time.parse(obj["started_at"]))

      return "@#{user}, #{channel} has been streaming #{game} for #{uptime} to #{views} viewers "
    end
  }
}