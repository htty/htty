require 'htty'

# Encapsulates the _form-add_ command.
class HTTY::CLI::Commands::FormAdd < HTTY::CLI::Command

  # Returns the name of a category under which help for the _form-add_ command
  # should appear.
  def self.category
    'Building Requests'
  end

end
