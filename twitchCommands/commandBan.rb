require 'pg'

def commandBan (user, message, db_params)

  banUser = message.split[1].downcase
  banCommand = message.split[2]

  conn = PG.connect(db_params)

  case banCommand
  when "ping", "say", "suggest", "nasa", "islive", "fill", "fishcatch", "fishpoints"
    query = "CALL \"addBannedUser\"('#{banUser}','#{banCommand}');"
    conn.exec(query)
    conn.close
    return "#{banUser} is now banned from using ??#{banCommand}"
  when nil
    query = "CALL \"addBannedUser\"('#{banUser}','bot');"
    conn.exec(query)
    conn.close
    return "#{banUser} is now banned from using the bot entirely"
  else
    return "error: couldn't find command usage: ??ban {user} {command}"
  end
end
