$command = {
  "name" => "eval",
  "isPrivate?" => true,
  "alias" => "eval debug",
  "method" => -> (params) {
    user = params[:user]
    parameters = params[:parameters]

    if parameters.nil?
      return "@#{user}, error, no input!"
    end

    begin
      data = instance_eval parameters.join(" ")
    rescue
      return "an error has occurred"
    end

    return data
  }
}
