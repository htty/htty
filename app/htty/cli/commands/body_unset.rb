# Defines HTTY::CLI::Commands::BodyUnset.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/body_request")
require File.expand_path("#{File.dirname __FILE__}/body_set")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _body-unset_ command.
class HTTY::CLI::Commands::BodyUnset < HTTY::CLI::Command

  # Returns the name of a category under which help for the _body-unset_ command
  # should appear.
  def self.category
    'Building Requests'
  end

  # Returns the help text for the _body-unset_ command.
  def self.help
    'Clears the body of the request'
  end

  # Returns the extended help text for the _body-unset_ command.
  def self.help_extended
    'Clears the body content used for the request. Does not communicate with ' +
    'the endpoint.'
  end

  # Returns related command classes for the _body-unset_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::BodyRequest, HTTY::CLI::Commands::BodySet]
  end

  # Performs the _body-unset_ command.
  def perform
    add_request_if_has_response do |request|
      request.body_unset
    end
  end

end
