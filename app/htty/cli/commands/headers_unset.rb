# Defines HTTY::CLI::Commands::HeadersUnset.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/headers_request")
require File.expand_path("#{File.dirname __FILE__}/headers_set")
require File.expand_path("#{File.dirname __FILE__}/headers_unset_all")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

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
    'name'
  end

  # Returns the help text for the _headers-unset_ command.
  def self.help
    'Removes a header of the request'
  end

  # Returns the extended help text for the _headers-unset_ command.
  def self.help_extended
    'Removes a header used for the request. Does not communicate with the ' +
    'endpoint.'
  end

  # Returns related command classes for the _headers-unset_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::HeadersRequest,
     HTTY::CLI::Commands::HeadersSet,
     HTTY::CLI::Commands::HeadersUnsetAll]
  end

  # Performs the _headers-unset_ command.
  def perform
    add_request_if_has_response do |request|
      request.header_unset(*arguments)
    end
  end

end
