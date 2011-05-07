require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../url_escaping")
require File.expand_path("#{File.dirname __FILE__}/address")
require File.expand_path("#{File.dirname __FILE__}/../../multipart")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _multipart-set_ command.
class HTTY::CLI::Commands::MultipartSet < HTTY::CLI::Command

  include HTTY::CLI::Display
  include HTTY::CLI::UrlEscaping
  include HTTY::Multipart 
  # Returns the name of a category under which help for the _multipart-set_ command
  # should appear.
  def self.category
    'Building Requests'
  end

  # Returns the help text for the _multipart-set_ command.
  def self.help
    'Sets multipart data in request'
  end

  # Returns the arguments for the command-line usage of the _query-set_ command.
  def self.command_line_arguments
    'NAME [[file:]VALUE [NAME [[file:]VALUE ...]]]'
  end

  # Returns the extended help text for the _multipart-set_ command.
  def self.help_extended
    'Sets one or more multipart fields used for the request. Does not '        +
    "communicate with the host.\n"                                             +
    "\n"                                                                       +
    "This command replaces any duplicate parameters instead of adding more.\n" +
    "\n"                                                                       +
    'The name(s) and value(s) of the query-string parameter(s) will be URL-'   +
    "encoded if necessary.\n"       
  end

  # Returns related command classes for the _multipart-set_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::MultipartClear, HTTY::CLI::Commands::MultipartRemove]
  end

  # Performs the _multipart-set_ command.
  def perform
    add_request_if_new do |request|
      self.class.notify_if_cookies_cleared request do
        multipart_set!(request) unless multipart?(request)
        escaped_arguments = escape_or_warn_of_escape_sequences(arguments)
        escaped_arguments.each_slice 2 do |name, value|
          if value =~ /^file:/
            request.multipart[name] = FilePart.new(name,value.gsub(/^file:/,"")) 
          else
            request.multipart[name] = StringPart.new(name,value) 
          end
        end
        request.body_update
        request
      end
    end
  end

end
