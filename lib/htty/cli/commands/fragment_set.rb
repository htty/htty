# Defines HTTY::CLI::Commands::FragmentSet.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../url_escaping")
require File.expand_path("#{File.dirname __FILE__}/address")
require File.expand_path("#{File.dirname __FILE__}/fragment_unset")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _fragment-set_ command.
class HTTY::CLI::Commands::FragmentSet < HTTY::CLI::Command

  include HTTY::CLI::UrlEscaping

  # Returns the name of a category under which help for the _fragment-set_
  # command should appear.
  def self.category
    'Navigation'
  end

  # Returns the arguments for the command-line usage of the _fragment-set_ command.
  def self.command_line_arguments
    'fragment'
  end

  # Returns the help text for the _fragment-set_ command.
  def self.help
    "Sets the fragment of the request's address"
  end

  # Returns the extended help text for the _fragment-set_ command.
  def self.help_extended
    'Sets the page fragment used for the request. Does not communicate with ' +
    "the endpoint.\n"                                                         +
    "\n"                                                                      +
    'The console prompt shows the address for the current request.'
  end

  # Returns related command classes for the _fragment-set_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::FragmentUnset,
     HTTY::CLI::Commands::Address]
  end

  # Performs the _fragment-set_ command.
  def perform
    add_request_if_has_response do |request|
      clean_arguments = arguments.collect do |a|
        a.gsub(/^#/, '')
      end
      request.fragment_set(*escape_or_warn_of_escape_sequences(clean_arguments))
    end
  end

end
