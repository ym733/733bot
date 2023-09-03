#Program starts here
system "cls"
puts "Program running"

load 'irc.rb'
$data = JSON.parse(File.read('./config.json'))

irc = IRC.new($data["username"], $data["channel"], $data["oauth"])
irc.connect

