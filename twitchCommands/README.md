# 733bot Commands

_not all commmds are open-source, reasons can range from: database dependency, command being too technical or too simple_

---

PUBLIC COMMANDS:

| command                            | description                                                                                           |
| ---------------------------------- | ----------------------------------------------------------------------------------------------------- |
| [??say](./commandSay.rb)           | Says the text that follows the command                                                                |
| [??ping/??pong](./commandPing.rb)  | shows how long the bot has been running for and Pings twitch and returns the latency                  |
| ??suggest                          | suggest command returns the suggestion id                                                             |
| [??nasa](./commandNasa.rb)         | API, returns today's nasa picture                                                                     |
| [??islive](./commandIsLive.rb)     | API, returns if the streamer is live and if they are live returns: game, uptime and number of viewers |
| ??checksuggest/??suggeststat       | (followed by the suggestion id), returns the status of your suggestion                                |
| ??bot                              | returns a short description about the bot                                                             |
| ??help/??commands                  | brings you here                                                                                       |
| [??fill](./commandFill.rb)         | fills the message with the input you give it                                                          |
| [??cat/??randcat](./commandCat.rb) | API, return a random picture of a cat                                                                 |

---

FISHING COMMANDS:

| command                           | description                                                                                                      |
| --------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| ??fishcatch/??catchfish/??fc/??cf | catch a fish to add to your points, has a 1 hour interval between each catch                                     |
| ??newuser                         | if you are a new user, creates a new file for you to start adding points                                         |
| ??rename                          | if you changed your twitch username you can rename the original file made and gain back all your previous points |
| ??fishpoints/??points             | returns the amounts of points you currently have                                                                 |

---

PRIVATE COMMANDS (only bot owner can use):

| command                            | description                                                                                            |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------ |
| [??quit](./commandQuit.rb)         | shuts down the bot                                                                                     |
| ??ban                              | bans a user from using a certain command or the entire                                                 |
| ??join                             | joins a channel and adds it to the system thus the bot keeps joining the channel everytime it restarts |
| [??tempjoin](./commandTempJoin.rb) | temporarily joins a channel only until the bot restarts                                                |
| ??restart                          | reboots the bot                                                                                        |
| [??pyramid](./commandPyramid.rb)   | makes a pyramid in chat (hopefully this command will be public soon)                                   |