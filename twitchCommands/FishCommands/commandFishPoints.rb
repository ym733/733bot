$command = {
  "name" => "fish",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "fishpoints points",
  "lastUsed" => "FishPoints",
  "coolDown" => 15,
  "method" => -> (params) {
    user_id = params[:tags]["user-id"]
    db = params[:irc].db

    data = db.get_fisher_info(user_id)

    if data.nil?
      return "your twitch id isn't in the database, if you are new please use newuser"
    end

    return "you have #{data["points"]} points"
  }
}
