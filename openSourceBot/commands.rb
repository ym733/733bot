
def commandCheck(message)
  $flag = false
  $num = 0

  @commands = Array.new
  @commands[0] = "!hello"

  while $num < @commands.size
    if @commands[$num].include? message
      $flag = true
      break
    end
    $num+=1
  end
end

def response (user, message)

  @responses = Array.new
  @responses[0] = "hello @#{user} 👋"

  return @responses[$num]

end
