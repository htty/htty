# Defines HTTY::CLI::Commands::PortSet.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/address")
require File.expand_path("#{File.dirname __FILE__}/scheme_set")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _port-set_ command.
class HTTY::CLI::Commands::PortSet < HTTY::CLI::Command

  # Returns the name of a category under which help for the _port-set_ command
  # should appear.
  def self.category
    'Navigation'
  end

  # Returns the arguments for the command-line usage of the _port-set_ command.
  def self.command_line_arguments
    'port'
  end

  # Returns the help text for the _port-set_ command.
  def self.help
    "Changes the TCP port of the request's address"
  end

  # Returns the extended help text for the _port-set_ command.
  def self.help_extended
    'Changes the TCP port used for the request. Does not communicate with '  +
    "the endpoint.\n"                                                        +
    "\n"                                                                     +
    "The port you supply must be an integer between 0 and 65,535. Changing " +
    "the port has no effect on the scheme, and vice versa.\n"                +
    "\n"                                                                     +
    'The console prompt shows the address for the current request.'
  end

  # Returns related command classes for the _port-set_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::Address, HTTY::CLI::Commands::SchemeSet]
  end

  # Performs the _port-set_ command.
  def perform
    add_request_if_has_response do |request|
      request.port_set(*arguments)
    end
  end

end
