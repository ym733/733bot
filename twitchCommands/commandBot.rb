$command = {
    "name" => "bot",
    "isPrivate?" => false,
    "alias" => "bot",
    "lastUsed" => "Bot",
    "coolDown" => 5,
    "method" => -> (params) {
      return "@#{params[:user]}, 733bot is a twitch chat bot, written in ruby, by ym733, => github.com/ym733/733bot"
    }
  }
  