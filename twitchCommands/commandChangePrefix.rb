$command = {
  "name" => "prefix",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "changeprefix prefix",
  "lastUsed" => "Prefix",
  "coolDown" => 5,
  "method" => -> (params) {
    channel = params[:channel]

    if channel.nil?
      return "Cant execute command in whispers"
    end

    parameters = params[:parameters]
    tags = params[:tags]
    irc = params[:irc]

    #only a mod or the broadcaster or the bot owner can use this command
    if tags["mod"] || tags["broadcaster"] || params[:user] == $data["owner_name"]
      if parameters.nil?
        return "error, no input!"
      end

      new_prefix = parameters.join(" ")
    else
      return "you are not allowed to execute this command in this channel"
    end

    irc.db.update_prefix(channel, new_prefix)
    irc.channels[channel]["prefix"] = new_prefix

    return "Successfully changed prefix to \"#{new_prefix}\""
  }
}
