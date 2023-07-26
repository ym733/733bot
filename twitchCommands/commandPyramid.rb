def commandpyramid (channel, user, message)
    if message.split[1] == nil || message.split[2] == nil || message.split[1].to_i <= 0 || message.split[1].to_i >= 10
        return "@#{user}, usage => ??pyramid (number 1-9) (emote)"
    end
    
    rows = message.split[1].to_i

    for row in 0..rows do
      send_privmsg(channel, "#{message.split[2]} "*row)
    end
  
    for row in 0...(rows) do
      send_privmsg(channel, "#{message.split[2]} " *(rows-row-1))
    end

    return nil
end