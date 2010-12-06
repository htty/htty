require File.expand_path("#{File.dirname __FILE__}/../../no_response_error")
require File.expand_path("#{File.dirname __FILE__}/../body_open_command")
require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/body_request_open")
require File.expand_path("#{File.dirname __FILE__}/body_response")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _body-response-open_ command.
class HTTY::CLI::Commands::BodyResponseOpen < HTTY::CLI::Command

  include HTTY::CLI::BodyOpenCommand

  # Returns the name of a category under which help for the _body-response-open_
  # command should appear.
  def self.category
    'Inspecting Responses'
  end

  # Returns the string used to invoke the _body-response-open_ command from the
  # command line.
  def self.command_line
    'body[-response]-open'
  end

  # Returns the help text for the _body-response-open_ command.
  def self.help
    'Opens the body of the response in an external program'
  end

  # Returns the preamble to the extended help text for the _body-response-open_
  # command.
  def self.help_extended_preamble
    'Opens the body content received in the response in a program on your '    +
    'system that is mapped to the type of content. Does not communicate with ' +
    'the host.'
  end

  # Returns related command classes for the _body-response-open_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::BodyResponse,
     HTTY::CLI::Commands::BodyRequestOpen]
  end

  # Performs the _body-response-open_ command.
  def perform
    unless (response = session.last_response)
      raise HTTY::NoResponseError
    end
    open response
  end

end
