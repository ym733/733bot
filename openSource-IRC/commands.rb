
def commandCheck(message)
  $flag = false
  $num = 0

  #to add more commands add here
  @commands = Array.new
  @commands[0] = "!hello"

  while $num < @commands.size
    if @commands[$num] == message.split[0]
      $flag = true
      break
    end
    $num+=1
  end
end

def response (user, message)

  #add the response here every command must have a corresponding message
  @responses = Array.new
  @responses[0] = "hello @#{user} 👋"

  return @responses[$num]

end
