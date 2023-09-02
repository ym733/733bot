def commandfill (user, message)
    if message.split[1] == nil
        return "@#{user}, give something for the bot to fill"
    end
    
    string = message.split[1..-1].join(" ")
    return "#{string} " * (500 / (string.size+1)).to_i
end