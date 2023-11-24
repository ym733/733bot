$command = {
  "name" => "suggest",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "suggest",
  "lastUsed" => "Suggest",
  "coolDown" => 60,
  "method" => -> (params) {
    parameters = params[:parameters]
    db = params[:irc].db

    if parameters.nil?
      return "error, no input!"
    end

    #saves suggestion
    Thread.new do
      db.add_suggestion(params[:user], parameters.join(" "))
    end

    #returns the new suggest id
    return "suggestion added! your suggestion id is ##{db.get_suggestion_id}"
  }
}