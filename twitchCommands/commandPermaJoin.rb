
def commandPermaJoin (user, message, method, db_params)
    if message.split[1] == nil
        return "@#{user}, error, no input!"
    elsif message.split[1][0] == '#'
        return "@#{user}, Try again without the '#'"
    end

    channel_to_join = message.split[1].downcase

    conn = PG.connect(db_params)
    query = "CALL \"joinChannel\"('#{channel_to_join}');"
    conn.exec(query)

    method.call channel_to_join
    return nil
end