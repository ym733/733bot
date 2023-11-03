$command = {
  "name" => "text_edit",
  "isPrivate?" => false,
  "chainable" => true,
  "alias" => "bold",
  "lastUsed" => "Bold",
  "coolDown" => 5,
  "method" => -> (params) {
    parameters = params[:parameters]

    if parameters.nil?
      return "give something for the bot to boldify"
    end

    characters = {
      'a' => '𝗮',
      'b' => '𝗯',
      'c' => '𝗰',
      'd' => '𝗱',
      'e' => '𝗲',
      'f' => '𝗳',
      'g' => '𝗴',
      'h' => '𝗵',
      'i' => '𝗶',
      'j' => '𝗷',
      'k' => '𝗸',
      'l' => '𝗹',
      'm' => '𝗺',
      'n' => '𝗻',
      'o' => '𝗼',
      'p' => '𝗽',
      'q' => '𝗾',
      'r' => '𝗿',
      's' => '𝘀',
      't' => '𝘁',
      'u' => '𝘂',
      'v' => '𝘃',
      'w' => '𝘄',
      'x' => '𝘅',
      'y' => '𝘆',
      'z' => '𝘇',
      'A' => '𝗔',
      'B' => '𝗕',
      'C' => '𝗖',
      'D' => '𝗗',
      'E' => '𝗘',
      'F' => '𝗙',
      'G' => '𝗚',
      'H' => '𝗛',
      'I' => '𝗜',
      'J' => '𝗝',
      'K' => '𝗞',
      'L' => '𝗟',
      'M' => '𝗠',
      'N' => '𝗡',
      'O' => '𝗢',
      'P' => '𝗣',
      'Q' => '𝗤',
      'R' => '𝗥',
      'S' => '𝗦',
      'T' => '𝗧',
      'U' => '𝗨',
      'V' => '𝗩',
      'W' => '𝗪',
      'X' => '𝗫',
      'Y' => '𝗬',
      'Z' => '𝗭',
      '1' => '𝟭',
      '2' => '𝟮',
      '3' => '𝟯',
      '4' => '𝟰',
      '5' => '𝟱',
      '6' => '𝟲',
      '7' => '𝟳',
      '8' => '𝟴',
      '9' => '𝟵',
      '0' => '𝟬'
    }

    #replacing every character with it's corresponding value in the hash, if exists
    return parameters.join(" ").gsub(/[#{characters.keys.join}]/) { |match| characters[match] }
  }
}
