$command = {
  "name" => "say",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "say",
  "lastUsed" => "Say",
  "coolDown" => 5,
  "method" => -> (params) {
    parameters = params[:parameters]

    if parameters.nil?
      return "error, no input!"
    end

    return parameters.join(" ")
  }
}
