$command = {
  "name" => "fish",
  "isPrivate?" => false,
  "alias" => "fishpoints points",
  "lastUsed" => "FishPoints",
  "coolDown" => 15,
  "method" => -> (params) {
    user_id = params[:tags]["user-id"]
    db = params[:irc].db

    rows = db.get_fisher_info(user_id)

    if rows.ntuples == 0
      return "your twitch id isn't in the database, if you are new please use newuser"
    end

    data = rows[0]

    return "you have #{data["fish_point"]} points"
  }
}
