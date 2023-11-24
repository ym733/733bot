puts "Program running"

require 'json'
load 'irc.rb'

config = JSON.parse(File.read('./config.json'))

irc = IRC.new(config["username"],config["oauth"],config["channels"])
irc.connect

puts "Connected!"

while irc.running
  message = irc.read_msg

  if message

    if message["command"]['command'] == 'PRIVMSG'
      user = message["source"]["nick"]
      channel = message["command"]["channel"]
      msg = message["parameters"]

      puts "#{user} in #{channel}: #{msg}"

    end
  end
end

irc.quit