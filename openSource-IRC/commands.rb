def commandCheck(message)
  
  #to add more commands add here
  @commands = [
    "!hello"
  ]

  @commands.each do |elem|
    if elem.split(" ").include? message.downcase
      return true
    end
  end
  return false
end

def response (user, message)

  #add the response here every command must have a corresponding message
  @responses = [
    "hello @#{user} 👋"
  ]

  #this is an anonymous function that returns the index of the command we are executing
  commandIndex = (-> (arr, sub) { arr.index { |str| str.include?(sub) } }).call(@commands, message.split[0].downcase)

  return @responses[commandIndex]
end
