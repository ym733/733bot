require "socket"
require 'logger'
load 'commands.rb'


class IRC

  def initialize(nick, channel, oauth, logger = nil)
    @logger = logger || Logger.new(STDOUT)
    @running = false
    @socket = nil

    @channel = channel
    @token = oauth
    @nick = nick
  end

  def connect
    @logger.info('initializing bot...')
    # Connect to the IRC server
    @socket = TCPSocket.new('irc.chat.twitch.tv', 6667)
    @running = true

    send_pass "PASS #{@token}"
    send_command "NICK #{@nick}"
    send_command "JOIN ##{@channel}"
    send_privmsg @channel, "bot running"

    @logger.info('bot connected...')

      while @running  do
        begin
        ready = IO.select([@socket])
        ready[0].each do |s|
          line = s.gets

          #puts line

          match = line.match(/:(.+)!(.+) PRIVMSG #(.+) :(.+)$/)

          user = match && match[1]
          message = match && match[4]
          channel = match && match[3]

          if message
            RunCommand(channel.strip, user.strip, message.strip)
          end
        rescue
          puts "error has occured exiting Program"
          @running = false
        end

          #@logger.info("<-- #{line}")
        end
      end

  end

  def send_pass(command)
    @socket.puts(command)
  end

  def send_command(command)
    puts "--> #{command}"
    @socket.puts("#{command}\r\n", 0)

  end

  def send_privmsg(channel, text)
    send_command "PRIVMSG ##{channel} :#{text}"
  end

  def RunCommand(channel, user, message)
    puts "##{channel} #{user}: #{message}"

    if message[0] != '!'
      return nil
    else
      commandCheck message.downcase.split[0]
      if $flag
        msg = response(user, message)

        send_privmsg channel, msg
      end
    end
  end

end
