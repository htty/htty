require 'htty'

# Encapsulates the _headers-unset_ command.
class HTTY::CLI::Commands::HeadersUnset < HTTY::CLI::Command

  # Returns the name of a category under which help for the _headers-unset_
  # command should appear.
  def self.category
    'Building Requests'
  end

  # Returns the arguments for the command-line usage of the _headers-unset_
  # command.
  def self.command_line_arguments
    'NAME'
  end

  # Returns the help text for the _headers-unset_ command.
  def self.help
    'Removes a header of the request'
  end

  # Returns the extended help text for the _headers-unset_ command.
  def self.help_extended
    'Removes a header used for the request. Does not communicate with the host.'
  end

  # Returns related command classes for the _headers-unset_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::HeadersRequest,
     HTTY::CLI::Commands::HeadersSet,
     HTTY::CLI::Commands::HeadersUnsetAll]
  end

  # Performs the _headers-unset_ command.
  def perform
    add_request_if_new do |request|
      request.header_unset(*arguments)
    end
  end

end
