# Defines HTTY::CLI::Commands::BodyRequest.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/body_response")
require File.expand_path("#{File.dirname __FILE__}/body_set")
require File.expand_path("#{File.dirname __FILE__}/body_unset")
require File.expand_path("#{File.dirname __FILE__}/headers_request")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _body-request_ command.
class HTTY::CLI::Commands::BodyRequest < HTTY::CLI::Command

  # Returns the name of a category under which help for the _body-request_
  # command should appear.
  def self.category
    'Building Requests'
  end

  # Returns the help text for the _body-request_ command.
  def self.help
    'Displays the body of the request'
  end

  # Returns the extended help text for the _body-request_ command.
  def self.help_extended
    'Displays the body content used for the request. Does not communicate ' +
    'with the endpoint.'
  end

  # Returns related command classes for the _body-request_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::BodySet,
     HTTY::CLI::Commands::BodyUnset,
     HTTY::CLI::Commands::HeadersRequest,
     HTTY::CLI::Commands::BodyResponse]
  end

  # Performs the _body-request_ command.
  def perform
    if (body = session.requests.last.body)
      puts body unless body.empty?
    end
    self
  end

end
