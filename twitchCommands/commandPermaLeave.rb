$command = {
  "name" => "leave",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "permaleave leaveperma",
  "lastUsed" => "PermaLeave",
  "coolDown" => 5,
  "method" => -> (params) {
    parameters = params[:parameters]
    channel = params[:channel]
    tags = params[:tags]
    db = params[:irc].db


    if params[:user] == $data["owner_name"]
      if parameters.nil?
        channel_to_leave = channel
      else
        channel_to_leave = parameters[0]
      end
      unless params[:irc].channel_names.include? channel_to_leave
        return "Channel not found: #{channel_to_leave}"
      end
    else
      if channel.nil?
        return "Cant execute command in whispers"
      end
      unless tags["broadcaster"]
        return "Only channel broadcaster can use this command"
      end
      channel_to_leave = channel
    end

    Thread.new do
      db.leave_channel(channel_to_leave)
    end

    params[:irc].leave_channel channel_to_leave.downcase
    return "leaving #{channel_to_leave}..."
  }
}

