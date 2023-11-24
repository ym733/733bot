$command = {
  "name" => "join",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "permajoin joinperma",
  "lastUsed" => "PermaJoin",
  "coolDown" => 5,
  "method" => -> (params) {
    parameters = params[:parameters]
    db = params[:irc].db

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

    Thread.new do
      db.join_channel channel_to_join.downcase, prefix
    end

    params[:irc].join channel_to_join.downcase, prefix
    return nil
  }
}
