$command = {
  "name" => "quit",
  "isPrivate?" => true,
  "chainable" => false,
  "alias" => "quit",
  "method" => -> (params) {
    method = params[:irc].method(:flip_running)

    method.call
    return "quitting..."
  }
}
