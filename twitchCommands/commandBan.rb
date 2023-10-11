$command = {
  "name" => "ban",
  "isPrivate?" => true,
  "alias" => "ban",
  "method" => -> (params) {
    user = params[:user]
    parameters = params[:parameters]

    if parameters.nil?
      return "@#{user}, error, no input!"
    end

    ban_user = parameters[0].downcase
    ban_command = parameters[1]

    dal = DAL.new

    case ban_command
    when "ping", "say", "suggest", "nasa", "islive", "fill", "fish", 'pyramid', 'followage', 'subage'
      dal.ban(ban_user, ban_command)
      dal.close
      return "@#{user}, #{ban_user} is now banned from using #{ban_command}"
    when nil
      dal.delete_bans(ban_user)
      dal.ban(ban_user, 'bot')
      dal.close
      return "@#{user}, #{ban_user} is now banned from using the bot entirely"
    else
      dal.close
      return "@#{user}, error: couldn't find command, usage: ??ban {user} {command}"
    end
  }
}
