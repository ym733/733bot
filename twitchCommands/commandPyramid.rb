$command = {
  "name" => "pyramid",
  "isPrivate?" => false,
  "alias" => "pyramid",
  "lastUsed" => "Pyramid",
  "coolDown" => 5,
  "method" => -> (params) {
    user = params[:user]
    channel = params[:channel]
    tags = params[:tags]
    parameters = params[:parameters]
    method = params[:irc].method(:send_privmsg)
    states = params[:irc].channels[channel]["state"]

    if !states["mod"]
      return "@#{user}, cant execute command, the bot is not a moderator here"
    elsif !tags["broadcaster"] && !tags["mod"]
      return "@#{user}, only moderators can execute this command"
    elsif parameters.nil? || parameters.length == 1 || parameters[0].to_i <= 0 || parameters[0].to_i >= 10
      return "@#{user}, usage => ??pyramid (number 1-9) (emote)"
    end

    rows = parameters[0].to_i

    for row in 0..rows do
      method.call(channel, "#{parameters[1]} " * row)
    end

    for row in 0...rows do
      method.call(channel, "#{parameters[1]} " * (rows-row-1))
    end

    return nil
  }
}
