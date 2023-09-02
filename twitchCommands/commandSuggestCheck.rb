require 'pg'

def commandSuggestCheck (user, message, db_params)

  if message.split[1] == nil
    return "@#{user}, error, no input!"
  end

  #error = bad request
  #ntuples == 0 = wrong id
  #other = it worked

  begin
    conn = PG.connect(db_params)
    query = "select \"suggestionStat\" from \"suggestions\" where id = #{message.split[1]};"
    response = conn.exec(query)
    if response.ntuples == 0
      conn.close
      return "@#{user}, error, invalid suggest id"
    end
    stat = response[0]["suggestionStat"]
    conn.close
  rescue PG::Error => e
    conn.close
    return "@#{user}, error, bad input!"
  end
  
  case stat
  when nil
    return "@#{user}, error, invalid suggest id"
  when "new"
    return "@#{user}, your suggestion is still new and unread"
  when "read"
    return "@#{user}, your suggestions has been read"
  when "done"
    return "@#{user}, your suggestion has been completed"
  when "denied"
    return "@#{user}, your suggestion has been denied"
  else
    return "@#{user}, comment: #{stat}"
  end

end
