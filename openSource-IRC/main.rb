#Program starts here

system "cls"
puts "Program running"

require 'json'
load 'irc.rb'

$data = JSON.parse(File.read('./config.json'))

irc = IRC.new($data["username"], $data["channel"], $data["oauth"])
irc.connect

