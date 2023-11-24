$command = {
  "name" => "text_edit",
  "isPrivate?" => false,
  "chainable" => true,
  "alias" => "fill",
  "lastUsed" => "Fill",
  "coolDown" => 5,
  "method" => -> (params) {
    parameters = params[:parameters]

    if parameters.nil?
      return "give something for the bot to fill"
    end

    string = ""

    loop do
      word = parameters[rand(parameters.length)]
      if string.length + word.length > 500
        parameters.delete(word)
        if parameters.length == 0
          break
        end
        next
      end
      string << "#{word} "
    end

    return string
  }
}
