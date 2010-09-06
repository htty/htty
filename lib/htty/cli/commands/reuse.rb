# Defines HTTY::CLI::Commands::Reuse.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../display")
require File.expand_path("#{File.dirname __FILE__}/history")
require File.expand_path("#{File.dirname __FILE__}/history_verbose")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _reuse_ command.
class HTTY::CLI::Commands::Reuse < HTTY::CLI::Command

  include HTTY::CLI::Display

  # Returns the name of a category under which help for the _reuse_ command
  # should appear.
  def self.category
    'Navigation'
  end

  # Returns the arguments for the command-line usage of the _reuse_ command.
  def self.command_line_arguments
    'index'
  end

  # Returns the help text for the _reuse_ command.
  def self.help
    'Copies a previous request by the index number shown in history'
  end

  # Returns the extended help text for the _reuse_ command.
  def self.help_extended
    'Copies the properties of a previous request to be used for the request, ' +
    'using the request index number shown in history. Does not communicate '   +
    "with the endpoint.\n"                                                     +
    "\n"                                                                       +
    'The argument is an index number that appears when you type '              +
    "#{strong HTTY::CLI::Commands::History.command_line}."
  end

  # Returns related command classes for the _reuse_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::History, HTTY::CLI::Commands::HistoryVerbose]
  end

  # Performs the _reuse_ command.
  def perform
    unless arguments.length == 1
      raise ArgumentError,
            "wrong number of arguments (#{arguments.length} for 1)"
    end

    requests = session.requests
    requests_with_responses = requests.select do |r|
      r.response
    end
    raise 'no requests in history' if requests_with_responses.empty?

    index = arguments.first.to_i
    unless (1..requests_with_responses.length).include?(index)
      raise ArgumentError,
            "index must be between 1 and #{requests_with_responses.length}"
    end

    add_request_if_has_response do
      requests[index - 1].send :dup_without_response
    end
  end

end
