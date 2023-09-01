## info

_This is a Twitch chat web-socket client I made and is written in ruby, used by **733bot**, which is a bot I host with this client locally._

_733bot is not active 24/7._

_I have made many changes to this open source code throughout._

_This is not the original code I use to host 733bot but a very close replica._

---

## running the bot yourself

_Following a couple of steps the bot can be run on any host machine,_ note- you need to have [`ruby`](https://www.ruby-lang.org/) installed in step 8 to run the bot

---

1. Download the repo as a zip file then unzip it
2. We will be working with 'openSource-IRC', so open the folder with a text editor so we can make changes to individual files, we won't be making any changes to "main.rb" or "irc.rb"
3. Open "oauth.rb" and edit the following: the OAuth token, username, and channel
4. Now the bot can run but it doesn't have commands so open "commands.rb" and you will find 2 arrays "@commands" and "@responses"
5. "@commands" matches the commands typed in chat, so add as many as needed
6. "@responses" is aligned with "@commands", so the "@commands[n]" will have the response of "@responses[n]", so add the responses respectively aligned with the commands
7. Now that all changes have been made we need to run the bot, open the file with the terminal (or if you are using an IDE run "main.rb")
8. After opening the file with the terminal run the following line `ruby main.rb`
9. At this point the bot should be running in chat and working fine
