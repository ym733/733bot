# openSource-IRC

This open-source IRC is an easy-to-use twitch chat client.

## IRC Class

The `IRC` class is the main class. It provides methods for connecting to the IRC.

### Methods

* `initialize(nick, oauth, channels?)`: Creates and instance of the class.
* `connect`: Connects to the IRC.
* `send_command(command)`: Sends a command to the IRC.
* `send_privmsg(channel, text)`: Sends a private message to a specified channel.
* `join_channel(channel)`: Joins an IRC channel.
* `leave_channel(channel)`: Leaves an IRC channel.
* `get_msg`: Receives a from the IRC.
* `quit`: Quits the IRC connection.

## Example Usage

```ruby
irc = IRC.new("username","oauth",["channels"])
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
```