def parse_message(message)
    parsed_message = {
      "tags" => nil,
      "source" => nil,
      "command" => nil,
      "parameters" => nil
    }
  
    idx = 0
    raw_tags_component = nil
    raw_source_component = nil
    raw_command_component = nil
    raw_parameters_component = nil
  
    #gets raw tags
    if message[idx] == '@'
      end_idx = message.index(' ')
      raw_tags_component = message[1..end_idx - 1]
      idx = end_idx + 1
    end
  
    #gets raw source
    if message[idx] == ':'
      idx += 1
      end_idx = message.index(' ', idx)
      raw_source_component = message[idx..end_idx - 1]
      idx = end_idx + 1
    end
  
    #gets raw commands
    end_idx = message.index(':', idx)
    end_idx = message.length if end_idx.nil?
    raw_command_component = message[idx..end_idx - 1].strip
  
    #the rest is parameters
    if end_idx != message.length
      idx = end_idx + 1
      raw_parameters_component = message[idx..-1]
    end
  
    # at this point in the code all the raw
    # components will have their values
    # and now we start parsing them
  
    parsed_message["command"] = parse_command(raw_command_component)
  
    if parsed_message["command"].nil?
      #if nil then an error has occurred
      return nil
    else
  
      parsed_message["tags"] = raw_tags_component && parse_tags(raw_tags_component)
      parsed_message["source"] = parse_source(raw_source_component)
      parsed_message["parameters"] = raw_parameters_component
  
    end
  
    parsed_message
  end
  
  def parse_tags(tags)
    dict_parsed_tags = {}
    parsed_tags = tags.split(';')
  
    parsed_tags.each do |tag|
      parsed_tag = tag.split('=')
      tag_value = parsed_tag[1] == '' ? nil : parsed_tag[1]
  
      case parsed_tag[0]
      when 'badges'
        if tag_value
          dict = {}
          badges = tag_value.split(',')
          badges.each do |pair|
            badge_parts = pair.split('/')
            dict[badge_parts[0]] = badge_parts[1]
          end
          dict_parsed_tags[parsed_tag[0]] = dict
        else
          dict_parsed_tags[parsed_tag[0]] = nil
        end
      when 'id', 'user-id', 'ban-duration', 'followers-only', 'slow'
        dict_parsed_tags[parsed_tag[0]] = tag_value
      when 'mod', 'subscriber', 'r9k', 'subs-only', 'emote-only'
        dict_parsed_tags[parsed_tag[0]] = tag_value == '1'
      else
        # Ignore this tag
      end
    end
  
    dict_parsed_tags
  end
  
  def parse_command(raw_command_component)
    parsed_command = nil
    command_parts = raw_command_component.split(' ')
  
    case command_parts[0]
    when 'JOIN', 'PART', 'PRIVMSG', 'USERSTATE', 'ROOMSTATE', 'NOTICE', 'CLEARCHAT'
      parsed_command = {
        "command" => command_parts[0],
        "channel" => command_parts[1]
      }
    when 'PING', 'RECONNECT'
      parsed_command = {
        "command" => command_parts[0]
      }
    when 'WHISPER'
      parsed_command = {
        "command" => command_parts[0],
        "whisperTo" => command_parts[1]
      }
    when 'CAP'
      parsed_command = {
        "command" => command_parts[0],
        "isCapRequestEnabled" => command_parts[2] == 'ACK'
      }
    when '001', '421', '002', '003', '004', '353', '366', '372', '375', '376'
      return nil
    else
      puts "\nUnexpected command: #{command_parts[0]}\n"
      return nil
    end
  
    parsed_command
  end
  
  def parse_source(raw_source_component)
    return nil if raw_source_component.nil?
  
    source_parts = raw_source_component.split('!')
    {
      "nick" => source_parts.length == 2 ? source_parts[0] : nil,
      "host" => source_parts.length == 2 ? source_parts[1] : source_parts[0]
    }
  end
  