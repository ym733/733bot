# 733bot Commands

PUBLIC COMMANDS: 

|command|description|
|-------|-----------|
|??say | Says the text that follows the command |
|??ping/??pong | shows how long the bot has been running for and Pings twitch and returns the latency |
|??suggest | suggest command returns the suggestion id |
|??nasa | API, returns today's nasa picture |
|??islive | API, returns if the streamer is live and if they are live returns: game, uptime and number of viewers |
|??checksuggest/??suggeststat | (followed by the suggestion id), returns the status of your suggestion |
|??bot | returns a short description about the bot |
|??help/??commands | brings you here |
|??fill | fills the message with the input you give it |
|??cat/??randcat | API, return a random picture of a cat |

PRIVATE COMMANDS (only bot owner can use):

|command|description|
|-------|-----------|
|??quit | shuts down the bot |
|??ban | bans a user from using a certain command or the entire |
|??join | joins a channel and adds it to the system thus the bot keeps joining the channel everytime it restarts |
|??tempjoin | temporarily joins a channel only until the bot restarts |
|??restart | reboots the bot |
|??pyramid | makes a pyramid in chat (hopefully this command will be public soon) | 

***
## info

*This bot is not going to be active 24/7, so adding this bot to your chat would be near useless*

*If you have any suggestion for the bot, type ?suggest with your suggestion, and if the bot is not active contact the owner 'ym733' via twitch whispers*

*Any other concerns regarding the bot contact 'ym733' via twitch whispers*

*** 
## running the bot yourself

*Following a couple steps the bot can be ran on any host machine,* PS. you need to have ruby installed in step 8 to run the bot

***
1. Download repo as zip file then unzip it
2. Open file with a text editor so we can make changes to individual files, we wont be making any changes to "main.rb" or "irc.rb"
3. Open "oauth.rb" and edit the following: the oauth token, user name, and channel
4. Now the bot can run but it doesnt have commands so open "commands.rb" and you will find 2 arrays "@commands" and "@responses" 
5. "@commands" matches the commands typed in chat, so add as many as needed
6. "@responses" is aligned with "@commands", so the "@commands[n]" will have the response of "@responses[n]", so add the responses respectively aligned with the commands
7. Now that all changes have been made we need to run the bot, open the file with the terminal (or if you are using an IDE run "main.rb")
8. After opening the file with the terminal run the following line `ruby main.rb`
9. At this point the bot should be running in chat nad working fine
