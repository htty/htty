require File.expand_path("#{File.dirname __FILE__}/../../request")
require File.expand_path("#{File.dirname __FILE__}/../../response")
require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../display")
require File.expand_path("#{File.dirname __FILE__}/history")
require File.expand_path("#{File.dirname __FILE__}/reuse")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _history-verbose_ command.
class HTTY::CLI::Commands::HistoryVerbose < HTTY::CLI::Command

  include HTTY::CLI::Display

  # Returns the name of a category under which help for the _history-verbose_
  # command should appear.
  def self.category
    'Navigation'
  end

  # Returns the help text for the _history_ command.
  def self.help
    'Displays the details of previous request-response activity in this session'
  end

  # Returns the extended help text for the _history_ command.
  def self.help_extended
    'Displays the details of previous request-response activity in this ' +
    "session. Does not communicate with the host.\n"                      +
    "\n"                                                                  +
    'All headers and body content of each request-response pair are shown.'
  end

  # Returns related command classes for the _history-verbose_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::History, HTTY::CLI::Commands::Reuse]
  end

  # Performs the _history-verbose_ command.
  def perform
    requests = session.requests
    number_width = Math.log10(requests.length).to_i + 1
    displayed_one = false
    requests.each_with_index do |request, index|
      next unless request.response

      puts(strong('-' * 80)) if displayed_one
      displayed_one = true

      number = (index + 1).to_s.rjust(number_width)
      print "#{strong number} "
      show_request request

      puts unless request.headers.empty?
      show_headers request.headers,
                   :show_asterisk_next_to => HTTY::Request::COOKIES_HEADER_NAME,
                   :show_mercantile_next_to => HTTY::Request::AUTHORIZATION_HEADER_NAME

      unless request.body.to_s.empty?
        puts
        puts request.body
      end

      puts
      show_response request.response

      puts unless request.response.headers.empty?
      show_headers request.response.headers,
                   :show_asterisk_next_to => HTTY::Response::COOKIES_HEADER_NAME

      unless request.response.body.to_s.empty?
        puts
        puts request.response.body
      end
    end
  end

end
