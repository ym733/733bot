$command = {
    "name" => "join",
    "isPrivate?" => true,
    "alias" => "permajoin joinperma",
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
  
      dal = DAL.new
      dal.join_channel(channel_to_join)
  
      dal.close
  
      method.call channel_to_join
      return nil
    }
  }
  