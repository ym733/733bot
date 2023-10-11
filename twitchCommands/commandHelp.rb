$command = {
    "name" => "bot",
    "isPrivate?" => false,
    "alias" => "help commands",
    "lastUsed" => "Commands",
    "coolDown" => 5,
    "method" => -> (params) {
      return "@#{params[:user]}, list of commands: https://github.com/ym733/733bot/tree/main/twitchCommands#readme"
    }
  }
  