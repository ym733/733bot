$command = {
    "name" => "suggest",
    "isPrivate?" => false,
    "alias" => "suggest",
    "lastUsed" => "Suggest",
    "coolDown" => 60,
    "method" => -> (params) {
      user = params[:user]
      parameters = params[:parameters]
  
      if parameters.nil?
        return "@#{user}, error, no input!"
      end
  
      #saves suggestion
      dal = DAL.new
      dal.add_suggestion(user, parameters.join(" "))
  
  
      #get amount of suggestions
      count = dal.get_suggestion_id[0]["count"]
  
      #close connection
      dal.close
  
      #returns the new suggest id
      return "@#{user}, suggestion added! your suggestion id is ##{count}"
    }
  }