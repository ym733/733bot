require 'json'
require 'pg'

def commandFishPoints(user, message, db_params)

  conn = PG.connect(db_params)
  query = "select * from \"fishPoints\" where username = '#{user}';"
  rows = conn.exec(query)

  if rows.ntuples == 0
    return "@#{user}, your username isn't in the database, if you are new please type ??newuser"
  end

  data = rows[0]

  return "@#{user}, you have #{data["fish_point"]} points"
end