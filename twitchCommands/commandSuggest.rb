require 'pg'

def commandSuggest (user, message, db_params)
    if message.split[1] == nil
        return "@#{user}, error!, no input"
    end
    
    #saves suggestion
    conn = PG.connect(db_params)
    #the following is a procedure in the database that adds a suggestion with the provided input
    query = "CALL \"addSuggestion\"('#{user}','#{message.split[1..-1].join(" ")}');"
    conn.exec(query)

    #get amount of suggestions
    query = "select count(id) from \"suggestion\";"
    count = conn.exec(query)[0]["count"]

    conn.close

    #returns the new suggest id
    return "@#{user}, suggestion added! your suggestion id is ##{count}"
end