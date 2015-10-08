require 'htty'

# Encapsulates the _form-remove_ command.
class HTTY::CLI::Commands::FormRemove < HTTY::CLI::Command

  # Returns the name of a category under which help for the _form-remove_
  # command should appear.
  def self.category
    'Building Requests'
  end

end
