def commandSubage(user, channel, parameters)

    targetChannel = channel
    targetUser = user
  
    #parameters validation
    if parameters.length == 1
      targetUser = parameters[0]
    elsif parameters.length == 2
      targetUser = parameters[0]
      targetChannel = parameters[1]
    elsif parameters.length > 2
      return "@#{user}, only 2 parameters or less needed, usage: ??subage (user) (channel)"
    end
  
    api_url = "https://api.ivr.fi/v2/twitch/subage/#{targetUser}/#{targetChannel}"
    subage = JSON.parse(Net::HTTP.get(URI(api_url)))
  
    if subage["statusHidden"]
      return "@#{user}, #{targetUser} has their subage on private"
    end
  
    if subage["meta"].nil?
      if subage["cumulative"]["months"] == 0
        return "@#{user}, #{targetUser} does not have an active subscription to #{targetChannel}, nor have they ever been subscribed"
      else
        return "@#{user}, #{targetUser} does not have an active subscription to #{targetChannel}, but they have been previously subbed for #{subage["cumulative"]["months"]} month(s)."
      end
    end
  
    if subage["meta"]["type"] == 'gift'
      "@#{user}, #{targetUser} has been subscribed to #{targetChannel} with a gifted sub by #{(subage["meta"]["giftMeta"]["gifter"].nil?)? "an anonymous gifter" : subage["meta"]["giftMeta"]["gifter"]["displayName"]} for #{subage["cumulative"]["months"]} months (on a #{subage["streak"]["months"]} month streak)! Sub ends in #{subage["cumulative"]["daysRemaining"]} days."
    else
      "@#{user}, #{targetUser} has been subscribed to #{targetChannel} for #{subage["cumulative"]["months"]} months (on a #{subage["streak"]["months"]} month streak)! Sub ends in #{subage["cumulative"]["daysRemaining"]} days."
    end
  end
  
  