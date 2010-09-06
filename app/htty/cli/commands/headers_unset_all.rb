# Defines HTTY::CLI::Commands::HeadersUnsetAll.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/headers_request")
require File.expand_path("#{File.dirname __FILE__}/headers_set")
require File.expand_path("#{File.dirname __FILE__}/headers_unset")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _headers-unset-all_ command.
class HTTY::CLI::Commands::HeadersUnsetAll < HTTY::CLI::Command

  # Returns the name of a category under which help for the _headers-unset-all_
  # command should appear.
  def self.category
    'Building Requests'
  end

  # Returns the help text for the _headers-unset-all_ command.
  def self.help
    'Removes all headers from the request'
  end

  # Returns the extended help text for the _headers-unset-all_ command.
  def self.help_extended
    'Removes all headers used for the request. Does not communicate with the ' +
    'endpoint.'
  end

  # Returns related command classes for the _headers-unset-all_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::HeadersRequest,
     HTTY::CLI::Commands::HeadersUnset,
     HTTY::CLI::Commands::HeadersSet]
  end

  # Performs the _headers-unset-all_ command.
  def perform
    add_request_if_has_response do |request|
      request.headers_unset_all(*arguments)
    end
  end

end
