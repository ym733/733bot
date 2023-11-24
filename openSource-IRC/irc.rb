require "socket"

class IRC

  attr_reader :running

  def initialize(nick, oauth, channels=[])
    @running = false
    @socket = nil

    @channels = channels
    @token = oauth
    @nick = nick
  end

  def connect
    @socket = TCPSocket.new('irc.chat.twitch.tv', 6667)
    @running = true

    send_pass "PASS #{@token}"
    send_command "NICK #{@nick}"
    send_command "CAP REQ :twitch.tv/commands twitch.tv/tags"
    @channels.each do |channel|
      join channel
    end
  end

  def send_command(command)
    check_running

    @socket.puts("#{command}\r\n")
  end

  def send_privmsg(channel, text)
    check_running

    send_command "PRIVMSG ##{channel} :#{text}"
  end

  def join_channel(channel)
    check_running

    if channel[0] == '#'
      channel = channel[1..]
    end

    unless @channels.include? channel
      @channels << channel
    end

    send_command "JOIN ##{channel}"
  end
  alias join join_channel

  def leave_channel(channel)
    check_running

    if channel[0] == '#'
      channel = channel[1..]
    end

    @channels.delete channel

    send_command "PART ##{channel}"
  end
  alias leave leave_channel

  def get_msg
    check_running

    ready = IO.select([@socket])
    ready[0].each do |s|
      line = s.gets

      return parse_message line
    end
  end
  alias recv_msg get_msg
  alias recieve_msg get_msg
  alias read_msg get_msg

  def quit
    check_running

    @channels.each do |channel|
      leave channel
    end

    send_command "QUIT"
    @running = false
  end
  alias stop quit

  private
  def send_pass(pass)
    @socket.puts(pass)
  end

  def check_running
    unless @running
      throw "Bot not connected, please use the `connect` method to connect the bot"
    end
  end

  def parse_message(message)
    parsed_message = {
      'tags' => nil,
      'source' => nil,
      'command' => nil,
      'parameters' => nil
    }

    idx = 0

    if message[idx] == '@'
      end_idx = message.index(' ')
      raw_tags_component = message[1..end_idx - 1]
      idx = end_idx + 1
    end

    if message[idx] == ':'
      idx += 1
      end_idx = message.index(' ', idx)
      raw_source_component = message[idx..end_idx - 1]
      idx = end_idx + 1
    end

    end_idx = message.index(':', idx)
    end_idx = message.length if end_idx.nil?
    raw_command_component = message[idx..end_idx - 1].strip

    if end_idx != message.length
      idx = end_idx + 1
      raw_parameters_component = message[idx..-1]
    end

    parsed_message['command'] = parse_command(raw_command_component)

    if parsed_message['command'].nil?
      return nil
    else

      parsed_message['tags'] = raw_tags_component && parse_tags(raw_tags_component)
      parsed_message['source'] = raw_source_component && parse_source(raw_source_component)
      parsed_message['parameters'] = raw_parameters_component&.chomp

    end

    parsed_message
  end
  def parse_tags(raw_tags_component)
    dict_parsed_tags = {}
    parsed_tags = raw_tags_component.split(';')

    parsed_tags.each do |tag|
      parsed_tag = tag.split('=')
      tag_value = parsed_tag[1] == '' ? nil : parsed_tag[1]

      case parsed_tag[0]
      when 'badges', 'badge-info'
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
      when 'emotes'
        if tag_value
          dict_emotes = {}
          emotes = tag_value.split('/')
          emotes.each do |emote|
            emote_parts = emote.split(':')
            text_positions = []
            positions = emote_parts[1].split(',')
            positions.each do |position|
              position_parts = position.split('-')
              text_positions << {
                "startPosition" => position_parts[0],
                "endPosition" => position_parts[1]
              }
            end
            dict_emotes[emote_parts[0]] = text_positions
          end
          dict_parsed_tags[parsed_tag[0]] = dict_emotes
        else
          dict_parsed_tags[parsed_tag[0]] = nil
        end
      when 'emote-sets'
        emote_set_ids = tag_value.split(',')
        dict_parsed_tags[parsed_tag[0]] = emote_set_ids
      else
        dict_parsed_tags[parsed_tag[0]] = tag_value
      end
    end

    dict_parsed_tags
  end
  def parse_command(raw_command_component)
    command_parts = raw_command_component.split(' ')

    case command_parts[0]
    when 'JOIN', 'PART', 'PRIVMSG', 'USERSTATE', 'ROOMSTATE', 'NOTICE', 'CLEARCHAT', 'USERNOTICE', 'HOSTTARGET', 'CLEARMSG'
      parsed_command = {
        'command' => command_parts[0],
        'channel' => command_parts[1]
      }
    when 'PING', 'RECONNECT', 'GLOBALUSERSTATE'
      parsed_command = {
        'command' => command_parts[0]
      }
    when 'WHISPER'
      parsed_command = {
        'command' => command_parts[0],
        'whisperTo' => command_parts[1]
      }
    when 'CAP'
      parsed_command = {
        'command' => command_parts[0],
        'isCapRequestEnabled' => command_parts[2] == 'ACK'
      }
    when '001', '421', '002', '003', '004', '353', '366', '372', '375', '376'
      return nil
    else
      puts "Unexpected command: #{command_parts[0]}"
      return nil
    end

    parsed_command
  end
  def parse_source(raw_source_component)
    source_parts = raw_source_component.split('!')
    {
      'nick' => source_parts.length == 2 ? source_parts[0] : nil,
      'host' => source_parts.length == 2 ? source_parts[1] : source_parts[0]
    }
  end
end
