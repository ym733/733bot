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
          #recieve message from IRC
          ready = IO.select([@socket])
          ready[0].each do |s|
          line = s.gets

          #message parser
          match = line.match(/:(.+)!(.+) PRIVMSG #(.+) :(.+)$/)

          user = match && match[1]
          message = match && match[4]
          channel = match && match[3]

          if message
            RunCommand(channel.strip, user.strip, message.strip)
          end
        rescue
          puts "error has occurred exiting Program"
          @running = false
        end
        end
      end

  end

  #for sending password to IRC
  def send_pass(command)
    @socket.puts(command)
  end

  #for sending a command to IRC
  def send_command(command)
    puts "--> #{command}"
    @socket.puts("#{command}\r\n", 0)

  end

  #for sending a chat message to IRC
  def send_privmsg(channel, text)
    send_command "PRIVMSG ##{channel} :#{text}"
  end

  #method for decoding a message
  def RunCommand(channel, user, message)
    puts "##{channel} #{user}: #{message}"

    #if the prefix exists in message then decode the command sent
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
