$command = {
  "name" => "fish",
  "isPrivate?" => false,
  "alias" => "newuser",
  "lastUsed" => "NewUser",
  "coolDown" => 5,
  "method" => -> (params) {
    user = params[:user]
    user_id = params[:tags]['user-id']
    db = params[:irc].db

    rows = db.get_fisher_info(user_id)

    if rows.ntuples != 0
      return "there already is a record with your twitch id, try using catchfish"
    end

    #for id
    id = db.get_max_id

    db.add_user(id.to_i + 1, user_id)

    return "your record was created successfully! your id is ##{id.to_i + 1}"
  }
}
