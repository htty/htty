require 'htty'

# Encapsulates the _exit_ command.
class HTTY::CLI::Commands::Exit < HTTY::CLI::Command

  # Returns the command that the _exit_ command is an alias for.
  def self.alias_for
    HTTY::CLI::Commands::Quit
  end

end
