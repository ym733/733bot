require 'httparty'
require 'pg'

def commandNewUser(user, message, db_params)

  conn = PG.connect(db_params)
  query = "select * from \"fishPoints\" where username = '#{user}';"
  rows = conn.exec(query)
  
  if rows.ntuples != 0
    conn.close
    return "@#{user}, there already is a record with your username, try typing ??cf"
  end
    
  #for id
  id = conn.exec("select max(id) from \"fishPoints\"")[0]["max"]
  #for twitch-id
  api_url = "https://decapi.me/twitch/id/#{user}"
  twitchID = Net::HTTP.get(URI(api_url))

  query = "call \"addUser\"(#{id.to_i + 1}, #{twitchID}, '#{user}', 0, #{(Time.now).to_i - 3600});"
  conn.exec(query)

  conn.close
  return "@#{user}, your record was created successfully! your id is ##{id.to_i + 1}"
end