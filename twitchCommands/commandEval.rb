$command = {
  "name" => "eval",
  "isPrivate?" => true,
  "chainable" => false,
  "alias" => "eval debug",
  "method" => -> (params) {
    parameters = params[:parameters]

    if parameters.nil?
      return "error, no input!"
    end

    begin
      data = instance_eval parameters.join(" ")
    rescue
      return "an error has occurred"
    end

    return data
  }
}
