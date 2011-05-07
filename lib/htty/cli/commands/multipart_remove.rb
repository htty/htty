require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../../multipart")
require File.expand_path("#{File.dirname __FILE__}/../url_escaping")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _multipart_remove_ command.
class HTTY::CLI::Commands::MultipartRemove < HTTY::CLI::Command

  include HTTY::CLI::UrlEscaping
  include HTTY::Multipart

  # Returns the name of a category under which help for the _multipart_remove_
  # command should appear.
  def self.category
    'Navigation'
  end

  # Returns the arguments for the command-line usage of the _query-set_ command.
  def self.command_line_arguments
    'NAME [NAME [NAME ...]]' 
  end


  # Returns the help text for the _multipart_remove_ command.
  def self.help
    "Removes one or more parts from request"
  end

  # Returns the extended help text for the _multipart_remove_ command.
  def self.help_extended
    "Removes one or more parts from request body. Does not communicate with the host.\n"
  end

  # Returns related command classes for the _multipart_remove_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::MultipartSet, HTTY::CLI::Commands::MultipartClear]
  end

  # Performs the _multipart_remove_ command.
  def perform
    add_request_if_new do |request|
      self.class.notify_if_cookies_cleared request do
        if multipart?(request)
          arguments.each do |arg|
            request.multipart.delete(escape_or_warn_of_escape_sequences([]<<arg)[0])
          end
          request.body_update
        end
      end
    end
  end

end
