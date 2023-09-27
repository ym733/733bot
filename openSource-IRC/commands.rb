def commandCheck(command)

  #to add more commands add here
  @commands = [
    "hello",
    "ping"
  ]

  @commands.each do |elem|
    if elem.split(" ").include? command
      return true
    end
  end
  return false
end

def response (user, message, prefix)

  #add the response here every command must have a corresponding message
  @responses = [
    "hello @#{user} 👋",
    "@#{user}, pong"
  ]

  #this is an anonymous function that returns the index of the command we are executing
  commandIndex = (-> (arr, sub) { arr.index { |str| str.include?(sub) } }).call(@commands, message.split[0][(prefix.length)..].downcase)

  return @responses[commandIndex]
end
