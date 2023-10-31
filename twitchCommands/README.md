# 733bot Commands

_not all commmds are open-source for various reasons_

_contributions to individual commands are welcome_

_some tools used here are not yet open-source such as IRC methods and DAL methods_

---

PUBLIC COMMANDS:

| Command                                                  | Description                                                                |
| -------------------------------------------------------- | -------------------------------------------------------------------------- |
| [??say](./commandSay.rb)                                 | Says the input you give                                                    |
| [??ping/??pong](./commandPing.rb)                        | shows how long the bot has been running for and returns the twitch latency |
| [??suggest](./commandSuggest.rb)                         | suggest command returns the suggestion id                                  |
| [??nasa](./commandNasa.rb)                               | API, returns today's nasa picture                                          |
| [??islive](./commandIsLive.rb)                           | API, returns: game, uptime and number of viewers, of the given streamer    |
| [??checksuggest/??suggeststat](./commandSuggestCheck.rb) | returns the status of the suggestion with the given suggestion id          |
| [??bot](./commandBot.rb)                                 | returns a short description about the bot                                  |
| [??help/??commands](./commandHelp.rb)                    | brings you here                                                            |
| [??fill](./commandFill.rb)                               | fills the message with the input you give it                               |
| [??pyramid](./commandPyramid.rb)                         | makes a pyramid in chat (only mods can use)                                |
| [??followage](./commandFollowage.rb)                     | API, checks the followage of a given user or a given channel               |
| [??subage](./commandSubage.rb)                           | API, checks the subage of a given user or a given a channel                |
| [??cat/??randcat](./commandCat.rb)                       | API, returns a random image of a cat                                       |
| [??dog/??randdog](./commandDog.rb)                       | API, returns a random image of a dog                                       |

---

[FISHING COMMANDS:](./FishCommands/)

| Command                                                                 | Description                                                                  |
| ----------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| [??fishcatch/??catchfish/??fc/??cf](./FishCommands/commandFishCatch.rb) | catch a fish to add to your points, has a 1 hour interval between each catch |
| [??newuser](./FishCommands/commandNewUser.rb)                           | if you are a new user, creates a new file for you to start adding points     |
| [??fishpoints/??points](./FishCommands/commandFishPoints.rb)            | returns the amounts of points you currently have                             |

---

[TEXT EDIT COMMANDS:](./TextEdit/)

| Command                                                     | Description                                      |
| ----------------------------------------------------------- | ------------------------------------------------ |
| [??fill](./TextEditCommands/commandFill.rb)                 | fills the message with the input you give it     |
| [??reverse](./TextEditCommands/commandReverse.rb)           | reverses the input you give it                   |
| [??shuffle](./TextEditCommands/commandShuffle.rb)           | shuffles the input you give it                   |
| [??small/??smol/??tiny](./TextEditCommands/commandSmall.rb) | turns the input you give into tiny characters    |
| [??bold](./TextEditCommands/commandBold.rb)                 | turns the input you give it into bold characters |

---

PRIVATE COMMANDS (only bot owner can use):

| Command                                            | Description                                                |
| -------------------------------------------------- | ---------------------------------------------------------- |
| [??quit](./commandQuit.rb)                         | shuts down the bot                                         |
| [??ban](./commandBan.rb)                           | bans a user from using a certain command or the entire bot |
| [??permajoin](./commandPermaJoin.rb)               | joins a channel permenantly even after restart             |
| [??tempjoin](./commandTempJoin.rb)                 | temporarily joins a channel only until the bot restarts    |
| ??restart                                          | reboots/restarts the bot                                   |
| [??eval/??debug](./commandEval.rb)                 | debugs the given input as ruby codes and retuns the result |
| [??templeave/??temppart](./commandTempLeave.rb)    | leaves a given channel or the current channel              |
| [??permaleave/??permapart](./commandPermaLeave.rb) | leave a given channel and deletes it from the database     |
