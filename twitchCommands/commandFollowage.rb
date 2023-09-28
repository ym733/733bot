def format_time_diff(time_diff)
    years = time_diff / (365 * 24 * 60 * 60)
    months = (time_diff % (365 * 24 * 60 * 60)) / (30 * 24 * 60 * 60)
    days = (time_diff % (30 * 24 * 60 * 60)) / (24 * 60 * 60)
    hours = (time_diff % (24 * 60 * 60)) / (60 * 60)
    minutes = (time_diff % (60 * 60)) / 60
    seconds = time_diff % 60
  
    formatted_time_diff = []
  
    formatted_time_diff << "#{years.to_i} year#{years > 1 ? 's' : ''}" if years > 0
    formatted_time_diff << "#{months.to_i} month#{months > 1 ? 's' : ''}" if months > 0
    formatted_time_diff << "#{days.to_i} day#{days > 1 ? 's' : ''}" if days > 0
    formatted_time_diff << "#{hours.to_i} hour#{hours > 1 ? 's' : ''}" if hours > 0
    formatted_time_diff << "#{minutes.to_i} minute#{minutes > 1 ? 's' : ''}" if minutes > 0
    formatted_time_diff << "#{seconds.to_i} second#{seconds > 1 ? 's' : ''}" if seconds > 0
  
    formatted_time_diff.join(', ')
end
  
def commandFollowage(user, channel, parameters)
  
    channelLookup = channel
    userLookup = user
 
    #parameters validation
    if parameters.length == 1
        userLookup = parameters[0]
    elsif parameters.length == 2
        userLookup = parameters[0]
        channelLookup = parameters[1]
    elsif parameters.length > 2
        return "@#{user}, only 2 parameters or less needed, usage: ??followage (user) (channel)"
    end
  
    api_url = "https://api.ivr.fi/v2/twitch/subage/#{userLookup}/#{channelLookup}"
    followedAt = JSON.parse(Net::HTTP.get(URI(api_url)))["followedAt"]
 
    if followedAt.nil?
        return "@#{user}, #{userLookup} does not follow #{channelLookup}"
    end
  
    "@#{user}, #{userLookup} has been following #{channelLookup} for #{format_time_diff((Time.now - Time.parse(followedAt)))}"
end
  