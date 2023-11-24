$command = {
  "name" => "text_edit",
  "isPrivate?" => false,
  "chainable" => true,
  "alias" => "reverse",
  "lastUsed" => "Reverse",
  "coolDown" => 5,
  "method" => -> (params) {
    parameters = params[:parameters]

    if parameters.nil?
      return "give something for the bot to reverse"
    end

    string = parameters.join(" ")
    return string.reverse
  }
}
