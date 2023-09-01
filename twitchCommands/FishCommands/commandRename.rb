require 'httparty'
require 'pg'

def commandRename(user, message, db_params)
  #checks for input
  if message.split[1] == nil
    return "@#{user}, error no input!"
  end

  oldUser = message.split[1].downcase

  conn = PG.connect(db_params)
  query = "select * from \"fishPoints\" where username = '#{user}' or username = '#{oldUser}';"
  rows = conn.exec(query)

  case rows.ntuples
  when 0
    conn.close
    return "@#{user}, neither your username nor the username you provided have records, please type ??newuser"

  when 1
    case rows[0]["username"]
    when user
      conn.close
      return "@#{user}, a record with that username does not exist"
    when oldUser
      # this is when it works
      data = rows[0]

      #for twitch-id
      api_url = "https://decapi.me/twitch/id/#{user}"
      twitchID = Net::HTTP.get(URI(api_url))

      if data["twitch_id"].to_i != twitchID.to_i
        return "@#{user}, sorry the twitch id does not match, if this is a new account contact the bot owner"
      end

      query = "CALL \"renameUser\"(#{data["id"]}, '#{user}')"
      conn.exec(query)

      return "@#{user}, successfully renamed record"
    end

  when 2
    conn.close
    return "@#{user}, there already is a record with your username"
  end
end