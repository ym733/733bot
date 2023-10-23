$command = {
  "name" => "ban",
  "isPrivate?" => true,
  "alias" => "ban",
  "method" => -> (params) {
    parameters = params[:parameters]
    commands = params[:irc].commands

    if parameters.nil?
      return "error, no input!"
    end

    ban_user = parameters[0].downcase
    ban_command = parameters[1]

    dal = DAL.new

    cmds = []
    commands.each { |command|
      unless cmds.include? command["name"].downcase
        cmds.append command["name"].downcase
      end
    }
    cmds.delete('bot')

    case ban_command
    when *cmds
      dal.ban(ban_user, ban_command)
      return_msg = "#{ban_user} is now banned from using #{ban_command}"
    when nil
      dal.delete_bans(ban_user)
      dal.ban(ban_user, 'bot')
      return_msg = "#{ban_user} is now banned from using the bot entirely"
    else
      return_msg = "error: couldn't find command, usage: ban {user} {command}"
    end

    dal.close
    return return_msg
  }
}
