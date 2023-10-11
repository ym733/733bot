$command = {
  "name" => "fish",
  "isPrivate?" => false,
  "alias" => "fishpoints points",
  "lastUsed" => "FishPoints",
  "coolDown" => 15,
  "method" => -> (params) {
    user = params[:user]

    dal = DAL.new
    rows = dal.get_fisher_info(user)

    if rows.ntuples == 0
      return "@#{user}, your username isn't in the database, if you are new please type ??newuser"
    end

    data = rows[0]

    return "@#{user}, you have #{data["fish_point"]} points"
  }
}
