# Defines HTTY::CLI::Commands::FormClear.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/form_remove_all")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _form-clear_ command.
class HTTY::CLI::Commands::FormClear < HTTY::CLI::Command

  # Returns the command that the _form-clear_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::FormRemoveAll
  end

  # Returns the name of a category under which help for the _form-clear_ command
  # should appear.
  def self.category
    'Building Requests'
  end

end
