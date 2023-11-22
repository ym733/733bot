require "socket"

load 'commands.rb'
load 'parser.rb'


class IRC

  def initialize(nick, channel, oauth)
    @running = false
    @socket = nil

    @channel = channel
    @token = oauth
    @nick = nick
  end

  def connect
    # Connect to the IRC server
    @socket = TCPSocket.new('irc.chat.twitch.tv', 6667)
    @running = true

    send_pass "PASS #{@token}"
    send_command "NICK #{@nick}"
    send_command "CAP REQ :twitch.tv/commands twitch.tv/tags"
    send_command "JOIN ##{@channel}"
    send_privmsg "bot running"

    while @running  do
      begin
        #recieve message from IRC
        ready = IO.select([@socket])
        ready[0].each do |s|
          line = s.gets

          #message parser
          parsedLine = parse_message line

          if parsedLine == nil
            puts line
            next
          end

          case parsedLine["command"]["command"]
          when 'PING'
            # If the message is a ping, send a pong back to the server
            puts line
            send_command "PONG :tmi.twitch.tv"
            next
          when 'PRIVMSG'
            user = parsedLine["source"]["nick"]
            message = parsedLine["parameters"]

            #channel if needed
            channel = parsedLine["command"]["channel"][1..-1]

            runCommand(user.strip, message.strip)
          end

        end
      rescue StandardError => e
        puts "error has occurred exiting Program"
        puts e.full_message
        @running = false
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
    @socket.puts("#{command}\r\n")

  end

  #for sending a chat message to IRC
  def send_privmsg(text)
    send_command "PRIVMSG ##{@channel} :#{text}"
  end

  #method for decoding a message
  def runCommand(user, message)
    puts "##{@channel} #{user}: #{message}"

    prefix = '!' #change prefix here

    #the message begins with the prefix then decode the command sent
    if message.start_with? prefix
      command = message.split[0][(prefix.length)..].downcase
      
      if commandCheck command
        send_privmsg response(user, message, prefix)
      end
    end
  end
end
