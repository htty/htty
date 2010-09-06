# Defines HTTY::CLI::Display.

module HTTY; end

class HTTY::CLI; end

# Encapsulates the display logic of _htty_'s command-line interface.
module HTTY::CLI::Display

  FORMATS = {:bold                    => '1',
             :underlined              => '4',
             :blinking                => '5',
             :inverse                 => '7',
             :foreground_black        => '30',
             :foreground_dark_red     => '31',
             :foreground_dark_green   => '32',
             :foreground_dark_yellow  => '33',
             :foreground_dark_blue    => '34',
             :foreground_dark_magenta => '35',
             :foreground_dark_cyan    => '36',
             :foreground_light_gray   => '37',
             :foreground_dark_default => '39',
             :foreground_dark_gray    => '1;30',
             :foreground_red          => '1;31',
             :foreground_green        => '1;32',
             :foreground_yellow       => '1;33',
             :foreground_blue         => '1;34',
             :foreground_magenta      => '1;35',
             :foreground_cyan         => '1;36',
             :foreground_white        => '1;37',
             :foreground_default      => '1;39',
             :background_black        => '40',
             :background_dark_red     => '41',
             :background_dark_green   => '42',
             :background_dark_yellow  => '43',
             :background_dark_blue    => '44',
             :background_dark_magenta => '45',
             :background_dark_cyan    => '46',
             :background_light_gray   => '47',
             :background_default      => '49'}

  def format(string, *attributes)
    segments = attributes.collect do |a|
      "\x1b[#{FORMATS[a]}m"
    end
    segments << string
    segments << "\x1b[0m"
    segments.join ''
  end

  def rescuing_from(*exception_classes)
    yield
  rescue Interrupt
    nil
  rescue *exception_classes => e
    $stderr.puts notice(sentence_case(e.message))
    nil
  end

  def indent(string, column=2)
    "#{' ' * column}#{string}"
  end

  def logotype
    format ' htty ', :bold, :background_dark_red, :foreground_yellow
  end

  def notice(string)
    "*** #{string}"
  end

  def normal(string)
    return string
    # format string, :foreground_dark_default
  end

  def say(message, style=:normal)
    puts send(style, notice(message))
  end

  def say_goodbye
    say 'Happy Trails To You!'
  end

  def say_header(message, style=:normal)
    puts send(style, notice('')) + highlight(messag)
  end

  def say_hello
    puts normal(notice('Welcome to ')) + logotype + normal(', the ') +
         strong('HTTP TTY') + normal('. Heck To The Yeah!')
  end

  def show_headers(headers, show_asterisk_next_to=nil)
    asterisk_symbol = nil
    margin = headers.inject 0 do |result, header|
      header_name = header.first
      asterisk_symbol ||= (header_name == show_asterisk_next_to) ? '*' : nil
      asterisk = (header_name == show_asterisk_next_to) ? asterisk_symbol : ''
      [(header_name.length + asterisk.length), result].max
    end
    headers.each do |name, value|
      asterisk = (name == show_asterisk_next_to) ? asterisk_symbol : nil
      puts "#{name.rjust margin - asterisk.to_s.length}:#{strong asterisk} " +
           value
    end
  end

  def show_request(request)
    method = format(" #{request.request_method.to_s.upcase} ", :inverse)
    print "#{method} "
    cookies_asterisk = request.cookies.empty? ? '' : strong('*')
    body_length = request.body.to_s.length
    body_size   = body_length.zero? ? 'empty' : "#{body_length}-character"
    puts [request.uri,
          pluralize('header', request.headers.length) + cookies_asterisk,
          "#{body_size} body"].join(' -- ')
  end

  def show_response(response)
    code, description = response.status
    case code.to_i
      when 100...200, 300...400
        print format(" #{code} ", :background_dark_blue, :foreground_white)
      when 200...300
        print format(" #{code} ", :background_dark_green, :foreground_black)
      when 500...600
        print format(" #{code} ", :inverse, :blinking,
                                  :background_black, :foreground_yellow)
      else
        print format(" #{code} ", :background_dark_red, :foreground_white)
    end
    print ' '
    cookies_asterisk = response.cookies.empty? ? '' : strong('*')
    body_length = response.body.to_s.length
    body_size   = body_length.zero? ? 'empty' : "#{body_length}-character"
    puts([description,
          pluralize('header', response.headers.length) + cookies_asterisk,
          "#{body_size} body"].join(' -- '))
  end

  def strong(string)
    format string, :bold
  end

  def word_wrap(text, column=nil)
    word_wrap_indented(text, (0..(column || 80)))
  end

  # Adapted from
  # http://api.rubyonrails.org/classes/ActionView/Helpers/TextHelper.html#M002281
  def word_wrap_indented(text, columns=2..80)
    indent_by, wrap_at = columns.min, columns.max - columns.min
    text.split("\n").collect do |line|
      (wrap_at < line.length)                              ?
      line.gsub(/(.{1,#{wrap_at}})(\s+|$)/, "\\1\n").strip :
      line
    end.join("\n").split("\n").collect do |line|
      indent line, indent_by
    end.join "\n"
  end

private

  def pluralize(word, number)
    case number
      when 0
        "no #{word}s"
      when 1
        "1 #{word}"
      else
        "#{number} #{word}s"
    end
  end

  def sentence_case(text)
    text.gsub(/^./) do |letter|
      letter.upcase
    end
  end

end
