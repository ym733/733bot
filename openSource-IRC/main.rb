#Program starts here
system "cls"
puts "Program running"

load 'irc.rb'
load 'oauth.rb'

irc = IRC.new($username, $channel, $oauth)
irc.connect

