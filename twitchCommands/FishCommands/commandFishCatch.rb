$command = {
  "name" => "fish",
  "isPrivate?" => false,
  "chainable" => false,
  "alias" => "fishcatch catchfish fc cf",
  "lastUsed" => "FishCatch",
  "coolDown" => 5,
  "method" => -> (params) {
    user_id = params[:tags]["user-id"]
    db = params[:irc].db

    data = db.get_fisher_info(user_id)

    #check if user exist in DB
    if data.nil?
      return "your twitch id isn't in the database, if you are new please use newuser"
    end

    if (Time.now).to_i - data["last_time_fish"] < 3600
      time = 3600 - ((Time.now).to_i - data["last_time_fish"])

      string = ""

      minutes = (time / 60 ) % 60
      seconds  = time % 60

      string = (minutes != 0)? string + "minutes: #{minutes}, ": string + ""
      string = (seconds != 0)? string + "seconds: #{seconds}, " : string + ""

      return "you already caught one! Please wait #{string} for another fish to appear"
    end

    points = data["points"]

    #prize decider
    num = rand(0..999)
    if num == 999
      points += 50
      prize = "you caught a Giant sea bass!🐟 50 points have been added: #{points} points"
    elsif num >= 0 && num <= 24
      points += 16
      prize = "you caught a Bluefin tuna!🐟 16 points have been added: #{points} points"
    elsif num >= 25 && num <= 124
      points += 10
      prize = "you caught a Salmon!🐟 10 points have been added: #{points} points"
    elsif num >= 125 && num <= 274
      points += 5
      prize = "you caught a Skipjack tuna!🐟 5 points have been added: #{points} points"
    elsif num >= 275 && num <= 524
      points += 3
      prize = "you caught a rockfish!🐟 3 points have been added: #{points} points"
    elsif num >= 525 && num <= 774
      points += 2
      prize = "you caught a whiting fish!🐟 2 points have been added: #{points} points"
    elsif num >= 775 && num <= 949
      prize = "you didnt catch any fish!🐟 no points added: #{points} points"
    elsif num >= 950 && num <= 998
      points -= 1
      prize = "you caught a sea sponge!🐟 1 point has been removed: #{points} points"
    else
      prize = "an error has occurred!"
    end

    Thread.new do
      db.update_fish_points(user_id, points)
    end

    return prize
  }
}
