# Defines HTTY::CLI::Commands::Status.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../display")
require File.expand_path("#{File.dirname __FILE__}/body_response")
require File.expand_path("#{File.dirname __FILE__}/headers_response")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _status_ command.
class HTTY::CLI::Commands::Status < HTTY::CLI::Command

  include HTTY::CLI::Display

  # Returns the name of a category under which help for the _status_ command
  # should appear.
  def self.category
    'Inspecting Responses'
  end

  # Returns the help text for the _status_ command.
  def self.help
    'Displays the status of the response'
  end

  # Returns the extended help text for the _status_ command.
  def self.help_extended
    'Displays the status signal received in the response. Does not ' +
    "communicate with the endpoint.\n"                               +
    "\n"                                                             +
    'Status is displayed automatically when a response is received.'
  end

  # Returns related command classes for the _status_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::BodyResponse, HTTY::CLI::Commands::HeadersResponse]
  end

  # Performs the _status_ command.
  def perform
    unless (response = session.last_response)
      raise HTTY::NoResponseError
    end
    show_response response
    self
  end

end
