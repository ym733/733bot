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
* `get_msg`: returns a parsed message from the IRC. [detailed documentation](#getmsg-documentation)
* `get_msg_raw`: returns a non-parsed message from the IRC.
* `quit`: Quits the IRC connection.

---

## `get_msg` Documentation

the messages returned from this method will look similar to what the [parser output](https://dev.twitch.tv/docs/irc/example-parser/#parser-output) shows in twitch's documentation

### Example - PRIVMSG:

**Raw message:**
```
@badge-info=;badges=moderator/1;client-nonce=c728ba9a6bf1143c8ae40f64c2781e1a;color=#0000FF;display-name=733Bot;emotes=;first-msg=0;flags=;id=dcdfb893-51e4-4776-a38c-314bc4177536;mod=1;returning-chatter=0;room-id=206749604;subscriber=0;tmi-sent-ts=1701404882520;turbo=0;user-id=606127463;user-type=mod :733bot!733bot@733bot.tmi.twitch.tv PRIVMSG #ym733 :test
```

**Parsed message:**
```json
{
  "tags": {
    "badge-info": null,
    "badges": {
      "moderator": "1"
    },
    "color": "#0000FF",
    "display-name": "733Bot",
    "emotes": null,
    "first-msg": "0",
    "flags": null,
    "id": "dcdfb893-51e4-4776-a38c-314bc4177536",
    "mod": "1",
    "returning-chatter": "0",
    "room-id": "206749604",
    "subscriber": "0",
    "tmi-sent-ts": "1701404882520",
    "turbo": "0",
    "user-id": "606127463",
    "user-type": "mod"
  },
  "source": {
    "nick": "733bot",
    "host": "733bot@733bot.tmi.twitch.tv"
  },
  "command": {
    "command": "PRIVMSG",
    "channel": "#ym733"
  },
  "parameters": "test"
}
```

### Example - PING:

**Raw message:**
```
PING :tmi.twitch.tv
```

**Parsed message:**
```json
{
  "tags": null,
  "source": null,
  "command": {
    "command": "PING"
  },
  "parameters": "tmi.twitch.tv"
}
```

### Example - ROOMSTATE:

**Raw message:**
```
@emote-only=0;followers-only=-1;r9k=0;room-id=206749604;slow=0;subs-only=0 :tmi.twitch.tv ROOMSTATE #ym733
```

**Parsed message:**
```json
{
  "tags": {
    "emote-only": "0",
    "followers-only": "-1",
    "r9k": "0",
    "room-id": "206749604",
    "slow": "0",
    "subs-only": "0"
  },
  "source": {
    "nick": null,
    "host": "tmi.twitch.tv"
  },
  "command": {
    "command": "ROOMSTATE",
    "channel": "#ym733"
  },
  "parameters": null
}
```

---

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

---

## Documentation for config.json

`oauth`: oauth is like your password to the bot, you can get an oauth token from the following website [_Twitch Chat Password Generator_](https://twitchapps.com/tmi/).

`username`: your bot's twitch username exactly as it is written on twitch, this helps with the identity verification.

`channels`: list of channels you want you bot to read messages from.