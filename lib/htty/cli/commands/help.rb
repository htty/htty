# Defines HTTY::CLI::Commands::Help.

require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../commands")
require File.expand_path("#{File.dirname __FILE__}/../display")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _help_ command.
class HTTY::CLI::Commands::Help < HTTY::CLI::Command

  include HTTY::CLI::Display

  # Returns the arguments for the command-line usage of the _help_ command.
  def self.command_line_arguments
    '[command]'
  end

  # Returns the help text for the _help_ command.
  def self.help
    'Displays this help table, or help on the specified command'
  end

  # Performs the _help_ command.
  def perform
    return display_help if arguments.empty?

    unless arguments.length == 1
      raise ArgumentError,
            "wrong number of arguments (#{arguments.length} for 1)"
    end

    display_help_for arguments.first
  end

private

  def display_help
    maximum_width = HTTY::CLI::Commands.inject 0 do |max, c|
      width = c.command_line.length + (c.command_line_arguments || '').length
      [max, width].max
    end
    categories_in_order = ['Navigation',
                           'Building Requests',
                           'Issuing Requests',
                           'Inspecting Responses',
                           nil]
    HTTY::CLI::Commands.select do |c|
      # Filter out commands not yet implemented.
      c.instance_methods(false).collect(&:to_sym).include?(:perform) ||
      (c.alias_for &&
       c.alias_for.instance_methods(false).collect(&:to_sym).include?(:perform))
    end.group_by(&:category).sort_by do |category, commands|
      # Group commands by category and give the categories a custom order.
      categories_in_order.index category
    end.each do |category, commands|
      category ||= 'Miscellaneous'
      puts
      puts((' ' * ((80 - category.length) / 2)) +
           strong(format(category, :underlined)))
      puts
      commands.each do |c|
        justification = maximum_width - c.command_line.length + 4
        puts indent(strong(c.command_line))                      +
             " #{c.command_line_arguments}".ljust(justification) +
             word_wrap_indented(c.help, (2 + maximum_width + 4)..80).lstrip
      end
    end
    puts
    self
  end

  def display_help_for(argument)
    if (command = HTTY::CLI::Commands.build_for(argument))
      c = command.class
      puts
      puts indent(strong(c.command_line)) + " #{c.command_line_arguments}"
      puts
      puts word_wrap_indented(c.help_extended)
      unless c.see_also_commands.empty?
        puts
        puts indent(strong('See also:'))
        puts
        (c.aliases + c.see_also_commands).each do |see_also_command|
          puts indent("* #{see_also_command.command_line}")
        end
      end
      puts
      return self
    end
    $stderr.puts notice("Can't display help for unrecognized command")
    puts notice("Try typing #{strong self.class.command_line}")
    self
  end

end
