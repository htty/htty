# Defines HTTY::CLI::Commands::HeadersResponse.

require File.expand_path("#{File.dirname __FILE__}/../../response")
require File.expand_path("#{File.dirname __FILE__}/../../no_response_error")
require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../display")
require File.expand_path("#{File.dirname __FILE__}/body_response")
require File.expand_path("#{File.dirname __FILE__}/cookies")
require File.expand_path("#{File.dirname __FILE__}/cookies_use")
require File.expand_path("#{File.dirname __FILE__}/headers_request")
require File.expand_path("#{File.dirname __FILE__}/status")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _headers-response_ command.
class HTTY::CLI::Commands::HeadersResponse < HTTY::CLI::Command

  include HTTY::CLI::Display

  # Returns the name of a category under which help for the _headers-response_
  # command should appear.
  def self.category
    'Inspecting Responses'
  end

  # Returns the string used to invoke the _headers-response_ command from the
  # command line.
  def self.command_line
    'headers[-response]'
  end

  # Returns the help text for the _headers-response_ command.
  def self.help
    'Displays the headers of the response'
  end

  # Returns the extended help text for the _headers-response_ command.
  def self.help_extended
    'Displays the headers received in the response. Does not communicate ' +
    'with the endpoint.'
  end

  # Returns related command classes for the _headers-response_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::BodyResponse,
     HTTY::CLI::Commands::Cookies,
     HTTY::CLI::Commands::CookiesUse,
     HTTY::CLI::Commands::Status,
     HTTY::CLI::Commands::HeadersRequest]
  end

  # Performs the _headers-response_ command.
  def perform
    unless (response = session.last_response)
      raise HTTY::NoResponseError
    end
    show_headers response.headers, HTTY::Response::COOKIES_HEADER_NAME
    self
  end

end
