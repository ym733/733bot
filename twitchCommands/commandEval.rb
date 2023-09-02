def commandEval(user, message)
    if message.split[1] == nil
      return "@#{user}, error, no input!"
    end
  
    begin
      data = instance_eval message.split[1..-1].join(" ")
    rescue
      return "an error has occurred"
    end
  
    return data
  end
  