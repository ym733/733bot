$command = {
  "name" => "leave",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "templeave leavetemp",
  "lastUsed" => "TempLeave",
  "coolDown" => 5,
  "method" => -> (params) {
    parameters = params[:parameters]
    tags = params[:tags]
    channel = params[:channel]

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

    params[:irc].leave_channel channel_to_leave.downcase
    return "leaving #{channel_to_leave}..."
  }
}

