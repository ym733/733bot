require 'pg'

def commandFishCatch(user, message, db_params)

  conn = PG.connect(db_params)
  query = "select * from \"fishPoints\" where username = '#{user}';"
  rows = conn.exec(query)

  #check if user exist in DB
  if rows.ntuples == 0
    conn.close
    return "@#{user}, your username isn't in the database, if you are new please type ??newuser"
  end
  
  data = rows[0]
  
  #check if user redeemed in the last hour
  if (Time.now).to_i - data["last_time_fish"].to_i < 3600
    time = 3600 - ((Time.now).to_i - data["last_time_fish"].to_i)
  
    string = ""
  
    minutes = (time / 60 ) % 60
    seconds  = time % 60
  
    string = (minutes != 0)? string + "minutes: #{minutes}, ": string + ""
    string = (seconds != 0)? string + "seconds: #{seconds}, " : string + ""

    conn.close
    return "@#{user}, you already caught one! Please wait #{string} for another fish to appear"
  end

  points = data["fish_point"].to_i
  
  #prize decider
  num = rand(0..999)
  if num == 999
    points += 50
    prize = "@#{user}, you caught a Giant sea bass!🐟 50 points have been added: #{points} points"
  elsif num >= 0 && num <= 24
    points += 16
    prize = "@#{user}, you caught a Bluefin tuna!🐟 16 points have been added: #{points} points"
  elsif num >= 25 && num <= 124
    points += 10
    prize = "@#{user}, you caught a Salmon!🐟 10 points have been added: #{points} points"
  elsif num >= 125 && num <= 274
    points += 5
    prize = "@#{user}, you caught a Skipjack tuna!🐟 5 points have been added: #{points} points"
  elsif num >= 275 && num <= 524
    points += 3
    prize = "@#{user}, you caught a rockfish!🐟 3 points have been added: #{points} points"
  elsif num >= 525 && num <= 774
    points += 2
    prize = "@#{user}, you caught a whiting fish!🐟 2 points have been added: #{points} points"
  elsif num >= 775 && num <= 949
    prize = "@#{user}, you didnt catch any fish!🐟 no points added: #{points} points"
  elsif num >= 950 && num <= 998
    points -= 1
    prize = "@#{user}, you caught a sea sponge!🐟 1 point has been removed: #{points} points"
  else
    prize = "an error has occurred!"
  end

  query = "call \"updateFishPoints\"(#{data["id"]}, #{data["twitch_id"]}, '#{user}', #{points}, #{(Time.now).to_i})"
  conn.exec(query)

  conn.close
  return prize
  end