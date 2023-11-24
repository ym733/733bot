$command = {
  "name" => "join",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "tempjoin jointemp",
  "lastUsed" => "TempJoin",
  "coolDown" => 5,
  "method" => -> (params) {
    parameters = params[:parameters]

    if params[:user] == $data["owner_name"]
      if parameters.nil?
        return "error, no input!"
      elsif parameters.length == 1
        channel_to_join = parameters[0]
        prefix = $data["default_prefix"]
      else
        channel_to_join = parameters[0]
        prefix = parameters[1..].join(" ")
      end
    else
      if params[:irc].channel_names.include? params[:user]
        return "error, already joined channel"
      end

      if parameters.nil?
        channel_to_join = params[:user]
        prefix = $data["default_prefix"]
      else
        channel_to_join = params[:user]
        prefix = parameters.join(" ")
      end
    end

    params[:irc].join channel_to_join.downcase, prefix
    return nil
  }
}
