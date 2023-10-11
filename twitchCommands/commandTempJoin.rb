$command = {
    "name" => "join",
    "isPrivate?" => true,
    "alias" => "jointemp tempjoin",
    "method" => -> (params) {
      user = params[:user]
      parameters = params[:parameters]
      method = params[:irc].method(:join)
  
      if parameters.nil?
            return "@#{user}, error, no input!"
        end
  
        if parameters[0][0] == '#'
            channel_to_join = parameters[0][1..-1].downcase
        else
            channel_to_join = parameters[0].downcase
        end
  
        method.call channel_to_join
        return nil
    }
  }
  