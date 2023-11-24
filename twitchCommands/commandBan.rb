$command = {
  "name" => "ban",
  "isPrivate?" => true,
  "chainable" => false,
  "alias" => "ban",
  "method" => -> (params) {
    parameters = params[:parameters]
    commands = params[:irc].commands
    db = params[:irc].db

    if parameters.nil?
      return "error, no input!"
    end

    ban_user = parameters[0].downcase
    ban_command = parameters[1]

    cmds = []
    commands.each do |command|
      unless cmds.include? command["name"].downcase
        cmds << command["name"].downcase
      end
    end
    cmds.delete('bot')

    case ban_command
    when *cmds
      Thread.new { db.ban(ban_user, ban_command) }
      return_msg = "#{ban_user} is now banned from using #{ban_command}"
    when nil
      Thread.new do
        db.delete_bans(ban_user)
        db.ban(ban_user, 'bot')
      end
      return_msg = "#{ban_user} is now banned from using the bot entirely"
    else
      return_msg = "error: couldn't find command, usage: ban {user} {command}"
    end

    return return_msg
  }
}
