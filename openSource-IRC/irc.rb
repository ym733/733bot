require "socket"
require 'logger'
load 'commands.rb'


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
    send_command "JOIN ##{@channel}"
    send_privmsg "bot running"

    while @running  do
      begin
        #recieve message from IRC
        ready = IO.select([@socket])
        ready[0].each do |s|
        line = s.gets

        # If the message is a ping, send a pong back to the server
        if line.start_with? "PING :tmi.twitch.tv"
          puts line
          send_command "PONG :tmi.twitch.tv"
          next
        end

        #message parser
        match = line.match(/:(.+)!(.+) PRIVMSG #([^ ]+) :(.+)$/)

        user = match && match[1]
        message = match && match[4]

        #channel if needed
        channel = match && match[3]

        #we check if the message sent matches our regex if so RunCommand is run
        if message
          RunCommand(user.strip, message.strip)
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
    @socket.puts("#{command}\r\n")

  end

  #for sending a chat message to IRC
  def send_privmsg(text)
    send_command "PRIVMSG ##{@channel} :#{text}"
  end

  #method for decoding a message
  def RunCommand(user, message)
    puts "##{@channel} #{user}: #{message}"

    #the message begins with the prefix then decode the command sent
    if message.start_with? '!'
      if commandCheck message.downcase.split[0]
        msg = response(user, message)

        send_privmsg msg
      end
    end
  end
end
