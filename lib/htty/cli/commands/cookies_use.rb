# Defines HTTY::CLI::Commands::CookiesUse.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/cookies")
require File.expand_path("#{File.dirname __FILE__}/cookies_add")
require File.expand_path("#{File.dirname __FILE__}/cookies_remove")
require File.expand_path("#{File.dirname __FILE__}/cookies_remove_all")
require File.expand_path("#{File.dirname __FILE__}/headers_response")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _cookies-use_ command.
class HTTY::CLI::Commands::CookiesUse < HTTY::CLI::Command

  # Returns the name of a category under which help for the _cookies-use_
  # command should appear.
  def self.category
    'Building Requests'
  end

  # Returns the help text for the _cookies-use_ command.
  def self.help
    'Uses cookies offered in the response'
  end

  # Returns the extended help text for the _cookies-use_ command.
  def self.help_extended
    'Sets the cookies of the request to the cookies offered in the response ' +
    "(the 'Set-Cookie' header). Does not communicate with the endpoint."
  end

  # Returns related command classes for the _cookies-use_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::Cookies,
     HTTY::CLI::Commands::CookiesAdd,
     HTTY::CLI::Commands::CookiesRemove,
     HTTY::CLI::Commands::CookiesRemoveAll,
     HTTY::CLI::Commands::HeadersResponse]
  end

  # Performs the _cookies-use_ command.
  def perform
    unless arguments.empty?
      raise ArgumentError,
            "wrong number of arguments (#{arguments.length} for 0)"
    end

    add_request_if_has_response do |request|
      request.cookies_use session.last_response
    end
  end

end
