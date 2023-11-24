$command = {
  "name" => "fish",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "newuser",
  "lastUsed" => "NewUser",
  "coolDown" => 5,
  "method" => -> (params) {
      user_id = params[:tags]['user-id']
      db = params[:irc].db

      data = db.get_fisher_info(user_id)

      unless data.nil?
          return "There already is a record with your twitch id, try using catchfish"
      end

      Thread.new do
          db.add_user(user_id)
      end

      return "your record was created successfully!"
  }
}
