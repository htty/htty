require File.expand_path("#{File.dirname __FILE__}/../body_open_command")
require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/body_request")
require File.expand_path("#{File.dirname __FILE__}/body_response_open")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _body-request-open_ command.
class HTTY::CLI::Commands::BodyRequestOpen < HTTY::CLI::Command

  include HTTY::CLI::BodyOpenCommand

  # Returns the name of a category under which help for the _body-request-open_
  # command should appear.
  def self.category
    'Building Requests'
  end

  # Returns the help text for the _body-request-open_ command.
  def self.help
    'Opens the body of the request in an external program'
  end

  # Returns the preamble to the extended help text for the _body-request-open_
  # command.
  def self.help_extended_preamble
    'Opens the body content used for the request in a program on your system ' +
    'that is mapped to the type of content. Does not communicate with the host.'
  end

  # Returns related command classes for the _body-request-open_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::BodyRequest,
     HTTY::CLI::Commands::BodyResponseOpen]
  end

  # Performs the _body-request-open_ command.
  def perform
    open session.requests.last
  end

end
