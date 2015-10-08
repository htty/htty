require 'htty'

# Encapsulates the _headers-set_ command.
class HTTY::CLI::Commands::HeadersSet < HTTY::CLI::Command

  # Returns the name of a category under which help for the _headers-set_
  # command should appear.
  def self.category
    'Building Requests'
  end

  # Returns the arguments for the command-line usage of the _headers-set_
  # command.
  def self.command_line_arguments
    'NAME VALUE'
  end

  # Returns the help text for the _headers-set_ command.
  def self.help
    'Sets a header of the request'
  end

  # Returns the extended help text for the _headers-set_ command.
  def self.help_extended
    'Sets a header used for the request. Does not communicate with the '  +
    "host.\n"                                                             +
    "\n"                                                                  +
    'Headers must have unique names. When you set a header that already ' +
    'exists, its value will be changed.'
  end

  # Returns related command classes for the _headers-set_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::HeadersRequest,
     HTTY::CLI::Commands::HeadersUnset,
     HTTY::CLI::Commands::HeadersUnsetAll]
  end

  # Performs the _headers-set_ command.
  def perform
    add_request_if_new do |request|
      request.header_set(*arguments)
    end
  end

end
