require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../../multipart")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _multipart_clear_ command.
class HTTY::CLI::Commands::MultipartClear < HTTY::CLI::Command

  include HTTY::Multipart

  # Returns the name of a category under which help for the _multipart_clear_
  # command should appear.
  def self.category
    'Navigation'
  end

  # Returns the help text for the _multipart_clear_ command.
  def self.help
    "Clears multipart request"
  end

  # Returns the extended help text for the _multipart_clear_ command.
  def self.help_extended
    "Clears the request body used for the request. Does not communicate with " +
    "the host.\n"                                                              +
    "\n"                                                                       +
    "The console prompt shows the address for the current request.\n"
  end

  # Returns related command classes for the _multipart_clear_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::MultipartRemove]
  end

  # Performs the _multipart_clear_ command.
  def perform
    add_request_if_new do |request|
      self.class.notify_if_cookies_cleared request do
        if multipart?(request)
          multipart_unset!(request)
        end
      end
    end
  end

end
