$command = {
  "name" => "text_edit",
  "isPrivate?" => false,
  "alias" => "small smol tiny",
  "lastUsed" => "Small",
  "coolDown" => 5,
  "method" => -> (params) {
    parameters = params[:parameters]

    if parameters.nil?
      return "give something for the bot to smallify"
    end

    #list taken from https://github.com/Supinic/supibot/blob/master/commands/texttransform/definitions/superscript.json
    characters = {  "0"=>"⁰",
                    "1"=>"¹",
                    "2"=>"²",
                    "3"=>"³",
                    "4"=>"⁴",
                    "5"=>"⁵",
                    "6"=>"⁶",
                    "7"=>"⁷",
                    "8"=>"⁸",
                    "9"=>"⁹",
                    " "=>" ",
                    "+"=>"⁺",
                    "-"=>"⁻",
                    "a"=>"ᵃ",
                    "b"=>"ᵇ",
                    "c"=>"ᶜ",
                    "d"=>"ᵈ",
                    "e"=>"ᵉ",
                    "f"=>"ᶠ",
                    "g"=>"ᵍ",
                    "h"=>"ʰ",
                    "i"=>"ⁱ",
                    "j"=>"ʲ",
                    "k"=>"ᵏ",
                    "l"=>"ˡ",
                    "m"=>"ᵐ",
                    "n"=>"ⁿ",
                    "o"=>"ᵒ",
                    "p"=>"ᵖ",
                    "r"=>"ʳ",
                    "s"=>"ˢ",
                    "t"=>"ᵗ",
                    "u"=>"ᵘ",
                    "v"=>"ᵛ",
                    "q"=>"ᶯ",
                    "w"=>"ʷ",
                    "x"=>"ˣ",
                    "y"=>"ʸ",
                    "z"=>"ᶻ",
                    "A"=>"ᴬ",
                    "B"=>"ᴮ",
                    "C"=>"ᶜ",
                    "D"=>"ᴰ",
                    "E"=>"ᴱ",
                    "F"=>"ᶠ",
                    "G"=>"ᴳ",
                    "H"=>"ᴴ",
                    "I"=>"ᴵ",
                    "J"=>"ᴶ",
                    "K"=>"ᴷ",
                    "L"=>"ᴸ",
                    "M"=>"ᴹ",
                    "N"=>"ᴺ",
                    "O"=>"ᴼ",
                    "P"=>"ᴾ",
                    "R"=>"ᴿ",
                    "S"=>"ˢ",
                    "T"=>"ᵀ",
                    "U"=>"ᵁ",
                    "V"=>"ⱽ",
                    "W"=>"ᵂ",
                    "X"=>"ˣ",
                    "Y"=>"ʸ",
                    "Z"=>"ᶻ"
    }

    #replacing every character with it's corresponding value in the hash, if exists
    return parameters.join(" ").gsub(/[#{characters.keys.join}]/) { |match| characters[match] }
  }
}