$command = {
  "name" => "fish",
  "isPrivate?" => false,
  "alias" => "newuser",
  "lastUsed" => "NewUser",
  "coolDown" => 5,
  "method" => -> (params) {
    user = params[:user]
    twitch_id = params[:tags]['id']

    dal = DAL.new
    rows = dal.get_fisher_info(user)

    if rows.ntuples != 0
      dal.close
      return "@#{user}, there already is a record with your username, try typing ??cf"
    end

    #for id
    id = dal.get_max_id[0]["max"]

    dal.add_user(id.to_i + 1, twitch_id, user)

    dal.close
    return "@#{user}, your record was created successfully! your id is ##{id.to_i + 1}"
  }
}
