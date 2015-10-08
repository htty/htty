require 'htty'

# Encapsulates the _form_ command.
class HTTY::CLI::Commands::Form < HTTY::CLI::Command

  # Returns the name of a category under which help for the _form_ command
  # should appear.
  def self.category
    'Building Requests'
  end

end
