# Defines HTTY::CLI::Commands::FragmentUnset.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/address")
require File.expand_path("#{File.dirname __FILE__}/fragment_set")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _fragment-unset_ command.
class HTTY::CLI::Commands::FragmentUnset < HTTY::CLI::Command

  # Returns the name of a category under which help for the _fragment-unset_
  # command should appear.
  def self.category
    'Navigation'
  end

  # Returns the help text for the _fragment-unset_ command.
  def self.help
    "Removes the fragment from the request's address"
  end

  # Returns the extended help text for the _fragment-unset_ command.
  def self.help_extended
    'Removes the page fragment used for the request. Does not communicate ' +
    "with the endpoint.\n"                                                  +
    "\n"                                                                    +
    'The console prompt shows the address for the current request.'
  end

  # Returns related command classes for the _fragment-unset_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::FragmentSet,
     HTTY::CLI::Commands::Address]
  end

  # Performs the _fragment-unset_ command.
  def perform
    add_request_if_has_response do |request|
      request.fragment_unset(*arguments)
    end
  end

end
