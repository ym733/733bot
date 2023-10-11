$command = {
    "name" => "fill",
    "isPrivate?" => false,
    "alias" => "fill",
    "lastUsed" => "Fill",
    "coolDown" => 5,
    "method" => -> (params) {
      user = params[:user]
      parameters = params[:parameters]
  
      if parameters.nil?
        return "@#{user}, give something for the bot to fill"
      end
  
      string = parameters.join(" ")
      return "#{string} " * (500 / (string.size+1)).to_i
    }
  }
  