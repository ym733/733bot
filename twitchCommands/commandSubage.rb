$command = {
  "name" => "subage",
  "isPrivate?" => false,
  "alias" => "subage",
  "lastUsed" => "Subage",
  "coolDown" => 15,
  "method" => -> (params) {
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
        return "@#{user}, only 2 parameters or less needed, usage: ??subage (user) (channel)"
      end
    end

    api_url = "https://api.ivr.fi/v2/twitch/subage/#{target_user}/#{target_channel}"
    subage = JSON.parse(Net::HTTP.get(URI(api_url)))

    if subage["statusHidden"]
      return "@#{user}, #{target_user} has their subage on private"
    end

    if subage["meta"].nil?
      if subage["cumulative"]["months"] == 0
        return "@#{user}, #{target_user} does not have an active subscription to #{target_channel}, nor have they ever been subscribed"
      else
        return "@#{user}, #{target_user} does not have an active subscription to #{target_channel}, but they have been previously subbed for #{subage["cumulative"]["months"]} month(s)."
      end
    end

    if subage["meta"]["type"] == 'gift'
      "@#{user}, #{target_user} has been subscribed to #{target_channel} with a gifted sub by #{(subage["meta"]["giftMeta"]["gifter"].nil?)? "an anonymous gifter" : subage["meta"]["giftMeta"]["gifter"]["displayName"]} for #{subage["cumulative"]["months"]} months (on a #{subage["streak"]["months"]} month streak)! Sub ends in #{subage["cumulative"]["daysRemaining"]} days."
    else
      "@#{user}, #{target_user} has been subscribed to #{target_channel} for #{subage["cumulative"]["months"]} months (on a #{subage["streak"]["months"]} month streak)! Sub ends in #{subage["cumulative"]["daysRemaining"]} days."
    end
  }
}
