# Defines HTTY::CLI::Commands::History.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../display")
require File.expand_path("#{File.dirname __FILE__}/history_verbose")
require File.expand_path("#{File.dirname __FILE__}/reuse")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _history_ command.
class HTTY::CLI::Commands::History < HTTY::CLI::Command

  include HTTY::CLI::Display

  # Returns the name of a category under which help for the _history_ command
  # should appear.
  def self.category
    'Navigation'
  end

  # Returns the help text for the _history_ command.
  def self.help
    'Displays previous request-response activity in this session'
  end

  # Returns the extended help text for the _history_ command.
  def self.help_extended
    'Displays previous request-response activity in this session. Does not '   +
    "communicate with the endpoint.\n"                                         +
    "\n"                                                                       +
    'Only a summary of each request-response pair is shown; headers and body ' +
    'content are omitted.'
  end

  # Returns related command classes for the _history_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::HistoryVerbose, HTTY::CLI::Commands::Reuse]
  end

  # Performs the _history_ command.
  def perform
    requests = session.requests
    number_width = Math.log10(requests.length).to_i + 1
    requests.each_with_index do |request, index|
      next unless request.response

      number = (index + 1).to_s.rjust(number_width)
      print "#{strong number} "
      show_request request

      print((' ' * number_width), ' ')
      show_response request.response
    end
  end

end
