def commandTempJoin (user, message)
    if message.split[1] == nil
        return "@#{user}, error, no intput!"
    elsif message.split[1][0] == '#'
        return "@#{user}, Try again without the '#'"
    end

    send_command "JOIN ##{message.split[1].downcase}"
    return "running in #{message.split[1].downcase} :D"
end