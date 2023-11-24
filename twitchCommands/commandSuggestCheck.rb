$command = {
  "name" => "suggest",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "checksuggest suggeststat",
  "lastUsed" => "Check",
  "coolDown" => 5,
  "method" => -> (params) {
    parameters = params[:parameters]
    db = params[:irc].db

    if parameters.nil?
      return "error, no input!"
    end

    #error = bad request
    #ntuples == 0 = wrong id
    #other = it worked


    response = db.get_suggestion(parameters[0])

    if response.nil?
      return "error, invalid suggest id"
    end

    if params[:user] != response["suggester"]
      return "suggester name does not match your username"
    end

    case response["stat"]
    when "new"
      return "your suggestion is still new and unread"
    when "read"
      return "your suggestions has been read"
    when "done"
      return "your suggestion has been completed"
    when "denied"
      return "your suggestion has been denied"
    else
      return "comment: #{response["comment"]}"
    end
  }
}
