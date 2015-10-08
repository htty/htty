require 'htty'

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
    "with the host.\n"                                                     +
    "\n"                                                                   +
    "A '#{HTTY::Response::COOKIES_HEADER_NAME}' request header is marked " +
    'with a bold asterisk (it looks like a cookie).'
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
    show_headers response.headers,
                 :show_asterisk_next_to => HTTY::Response::COOKIES_HEADER_NAME
    self
  end

end
