$command = {
  "name" => "say",
  "isPrivate?" => false,
  "alias" => "say",
  "lastUsed" => "Say",
  "coolDown" => 5,
  "method" => -> (params) {
    user = params[:user]
    parameters = params[:parameters]

    if parameters.nil?
      return "@#{user}, error, no input!"
    end

    return parameters.join(" ")
  }
}
