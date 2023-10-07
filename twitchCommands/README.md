# 733bot Commands

_not all commmds are open-source for various reasons_

_contributions to individual commands are welcome_

---

PUBLIC COMMANDS:

| command                                                  | description                                                                                           |
| -------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| [??say](./commandSay.rb)                                 | Says the text that follows the command                                                                |
| [??ping/??pong](./commandPing.rb)                        | shows how long the bot has been running for and Pings twitch and returns the latency                  |
| [??suggest](./commandSuggest.rb)                         | suggest command returns the suggestion id                                                             |
| [??nasa](./commandNasa.rb)                               | API, returns today's nasa picture                                                                     |
| [??islive](./commandIsLive.rb)                           | API, returns if the streamer is live and if they are live returns: game, uptime and number of viewers |
| [??checksuggest/??suggeststat](./commandSuggestCheck.rb) | (followed by the suggestion id), returns the status of your suggestion                                |
| ??bot                                                    | returns a short description about the bot                                                             |
| ??help/??commands                                        | brings you here                                                                                       |
| [??fill](./commandFill.rb)                               | fills the message with the input you give it                                                          |
| [??followage](./commandFollowage.rb)                     | checks the followage of a given user or a given channel                                               |
| [??subage](./commandSubage.rb)                           | checks the subage of a given user or a given a channel                                                |

---

[FISHING COMMANDS:](./FishCommands/)

| command                                                                 | description                                                                                                      |
| ----------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| [??fishcatch/??catchfish/??fc/??cf](./FishCommands/commandFishCatch.rb) | catch a fish to add to your points, has a 1 hour interval between each catch                                     |
| [??newuser](./FishCommands/commandNewUser.rb)                           | if you are a new user, creates a new file for you to start adding points                                         |
| [??rename](./FishCommands/commandRename.rb)                             | if you changed your twitch username you can rename the original file made and gain back all your previous points |
| [??fishpoints/??points](./FishCommands/commandFishPoints.rb)            | returns the amounts of points you currently have                                                                 |

---

PRIVATE COMMANDS (only bot owner can use):

| command                            | description                                                                                            |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------ |
| [??quit](./commandQuit.rb)         | shuts down the bot                                                                                     |
| [??ban](./commandBan.rb)           | bans a user from using a certain command or the entire                                                 |
| [??join](./commandPermaJoin.rb)    | joins a channel and adds it to the system thus the bot keeps joining the channel everytime it restarts |
| [??tempjoin](./commandTempJoin.rb) | temporarily joins a channel only until the bot restarts                                                |
| ??restart                          | reboots the bot                                                                                        |
| [??pyramid](./commandPyramid.rb)   | makes a pyramid in chat (hopefully this command will be public soon)                                   |
| [??eval/??debug](./commandEval.rb) | debugs the given input as ruby codes and retuns the result                                             |
| ??leave/??part                     | leaves a given channel or the current channel if no channel is given                                   |
