require 'htty'

# Encapsulates the _form-remove-all_ command.
class HTTY::CLI::Commands::FormRemoveAll < HTTY::CLI::Command

  # Returns the name of a category under which help for the _form-remove-all_
  # command should appear.
  def self.category
    'Building Requests'
  end

end
