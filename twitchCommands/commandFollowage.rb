$command = {
    "name" => "followage",
    "isPrivate?" => false,
    "alias" => "followage",
    "lastUsed" => "Followage",
    "coolDown" => 15,
    "method" => -> (params) {
      def format_time_diff(time_diff)
        years = (time_diff / (365 * 24 * 60 * 60)).to_i
        months = ((time_diff % (365 * 24 * 60 * 60)) / (30 * 24 * 60 * 60)).to_i
        days = ((time_diff % (30 * 24 * 60 * 60)) / (24 * 60 * 60)).to_i
        hours = ((time_diff % (24 * 60 * 60)) / (60 * 60)).to_i
        minutes = ((time_diff % (60 * 60)) / 60).to_i
        seconds = (time_diff % 60).to_i
  
        formatted_time_diff = []
  
        formatted_time_diff << "#{years} year#{years > 1 ? 's' : ''}" if years > 0
        formatted_time_diff << "#{months} month#{months > 1 ? 's' : ''}" if months > 0
        formatted_time_diff << "#{days} day#{days > 1 ? 's' : ''}" if days > 0
        formatted_time_diff << "#{hours} hour#{hours > 1 ? 's' : ''}" if hours > 0
        formatted_time_diff << "#{minutes} minute#{minutes > 1 ? 's' : ''}" if minutes > 0
        formatted_time_diff << "#{seconds} second#{seconds > 1 ? 's' : ''}" if seconds > 0
  
        formatted_time_diff.join(', ')
      end
  
      user = params[:user]
      target_channel = params[:channel]
      parameters = params[:parameters]
      target_user = user
  
      #parameters validation
      unless parameters.nil?
        if parameters.length == 1
          target_user = parameters[0]
        elsif parameters.length == 2
          target_user = parameters[0]
          target_channel = parameters[1]
        elsif parameters.length > 2
          return "@#{user}, only 2 parameters or less needed, usage: ??followage (user) (channel)"
        end
      end
  
  
      api_url = "https://api.ivr.fi/v2/twitch/subage/#{target_user}/#{target_channel}"
      followed_at = JSON.parse(Net::HTTP.get(URI(api_url)))["followedAt"]
  
      if followed_at.nil?
        return "@#{user}, #{target_user} does not follow #{target_channel}"
      end
  
      "@#{user}, #{target_user} has been following #{target_channel} for #{format_time_diff((Time.now - Time.parse(followed_at)))}"
    }
  }
  