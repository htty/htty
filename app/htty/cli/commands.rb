# Loads constants defined within HTTY::CLI::Commands.

module HTTY; end

class HTTY::CLI; end

# Contains classes that implement commands in the user interface.
module HTTY::CLI::Commands

  extend Enumerable

  # Returns a HTTY::CLI::Command descendant whose command line representation
  # matches the specified _command_line_. If an _attributes_ hash is specified,
  # it is used to initialize the command.
  def self.build_for(command_line, attributes={})
    each do |klass|
      if (command = klass.build_for(command_line, attributes))
        return command
      end
    end
    nil
  end

  # Yields each HTTY::CLI::Command descendant in turn.
  def self.each
    Dir.glob "#{File.dirname __FILE__}/commands/*.rb" do |f|
      class_name = File.basename(f, '.rb').gsub(/^(.)/) do |initial|
        initial.upcase
      end.gsub(/_(\S)/) do |initial|
        initial.gsub(/_/, '').upcase
      end
      klass = const_get(class_name) rescue nil
      yield klass if klass
    end
    self
  end

end

Dir.glob "#{File.dirname __FILE__}/commands/*.rb" do |f|
  require File.expand_path("#{File.dirname __FILE__}/commands/" +
                           File.basename(f, '.rb'))
end
