require 'htty'

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
    'with the host.'
  end

  # Returns related command classes for the _body-request_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::BodyRequestOpen,
     HTTY::CLI::Commands::BodySet,
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
