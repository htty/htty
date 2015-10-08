require 'htty'

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
