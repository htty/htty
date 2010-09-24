require File.expand_path("#{File.dirname __FILE__}/../../response")
require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/address")
require File.expand_path("#{File.dirname __FILE__}/http_get")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _follow_ command.
class HTTY::CLI::Commands::Follow < HTTY::CLI::Command

  # Returns the name of a category under which help for the _follow_ command
  # should appear.
  def self.category
    'Navigation'
  end

  # Returns the help text for the _follow_ command.
  def self.help
    "Changes the address of the request to the value of the response's " +
    "'#{HTTY::Response::LOCATION_HEADER_NAME}' header"
  end

  # Returns the extended help text for the _follow_ command.
  def self.help_extended
    "Changes the address of the request to the value of the response's "      +
    "'#{HTTY::Response::LOCATION_HEADER_NAME}' header. Does not communicate " +
    'with the host.'
  end

  # Returns related command classes for the _follow_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::Address, HTTY::CLI::Commands::HttpGet]
  end

  # Performs the _follow_ command.
  def perform
    unless arguments.empty?
      raise ArgumentError,
            "wrong number of arguments (#{arguments.length} for 0)"
    end

    add_request_if_has_response do |request|
      self.class.notify_if_cookies_cleared request do
        request.follow session.last_response
      end
    end
  end

end
