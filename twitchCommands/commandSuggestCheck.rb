$command = {
  "name" => "suggest",
  "isPrivate?" => false,
  "alias" => "checksuggest suggeststat",
  "lastUsed" => "Check",
  "coolDown" => 5,
  "method" => -> (params) {
    user = params[:user]
    parameters = params[:parameters]

    if parameters.nil?
       return "@#{user}, error, no input!"
    end

    #error = bad request
    #ntuples == 0 = wrong id
    #other = it worked

    dal = DAL.new

    begin

      response = dal.get_suggestion_stat(parameters[0])

      if response.ntuples == 0
        dal.close
        return "@#{user}, error, invalid suggest id"
      end

      stat = response[0]["suggestionStat"]
      suggester = response[0]["suggester"]
      dal.close
    rescue
      dal.close
      return "@#{user}, error, bad input!"
    end

    if user != suggester
      return "@#{user}, suggester name does not match your username"
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
  }
}
