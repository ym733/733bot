$command = {
    "name" => "leave",
    "isPrivate?" => true,
    "alias" => "permaleave permapart",
    "method" => -> (params) {
      parameters = params[:parameters]
      method = params[:irc].method(:leave)
      threads = params[:irc].threads
  
      if parameters.nil?
        channel_to_leave = params[:channel]
      else
        if parameters[0][0] == '#'
          channel_to_leave = parameters[0][1..-1].downcase
        else
          channel_to_leave = parameters[0].downcase
        end
      end
  
      dal = DAL.new
      dal.leave_channel(channel_to_leave)
      dal.close
  
      method.call channel_to_leave
      thread = threads[0]
      threads.pop
      thread.kill
      return "leaving #{channel_to_leave}"
    }
}
  