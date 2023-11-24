$command = {
  "name" => "text_edit",
  "isPrivate?" => false,
  "chainable" => true,
  "alias" => "shuffle",
  "lastUsed" => "Shuffle",
  "coolDown" => 5,
  "method" => -> (params) {
    parameters = params[:parameters]

    if parameters.nil?
      return "give something for the bot to shuffle"
    end

    return parameters.shuffle.join(" ")
  }
}
