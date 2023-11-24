$command = {
  "name" => "pyramid",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "pyramid",
  "lastUsed" => "Pyramid",
  "coolDown" => 5,
  "method" => -> (params) {
    channel = params[:channel]

    if channel.nil?
      return "can't execute command in whispers"
    end

    tags = params[:tags]
    parameters = params[:parameters]
    irc = params[:irc]
    states = params[:irc].channels[channel]["state"]

    if !states["mod"]
      return "cant execute command, the bot is not a moderator here"
    elsif !tags["broadcaster"] && !tags["mod"]
      return "only moderators can execute this command"
    elsif parameters.nil? || parameters.length == 1 || parameters[0].to_i <= 0 || parameters[0].to_i >= 10
      return "usage => pyramid (number 1-9) (emote)"
    end

    rows = parameters[0].to_i

    for row in 1..rows do
      irc.send_privmsg channel, "#{parameters[1]} " * row
    end

    for row in 0...rows-1  do
      irc.send_privmsg channel, "#{parameters[1]} " * (rows-row-1)
    end

    return nil
  }
}
