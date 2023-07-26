def commandSay (user, message)
    
    if message.split[1] == nil
      return "@#{user}, give something for the bot to say"
    end
      
    return message.split[1.. message.size].join(" ")
  end