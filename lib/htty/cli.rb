require File.expand_path("#{File.dirname __FILE__}/cli/commands")
require File.expand_path("#{File.dirname __FILE__}/cli/commands/help")
require File.expand_path("#{File.dirname __FILE__}/cli/input_device")
require File.expand_path("#{File.dirname __FILE__}/cli/display")
require File.expand_path("#{File.dirname __FILE__}/session")
require File.expand_path("#{File.dirname __FILE__}/version")

module HTTY; end

# Encapsulates the command-line interface to _htty_.
class HTTY::CLI

  include HTTY::CLI::Display

  # Returns the HTTY::Session created from command-line arguments.
  attr_reader :session

  # Instantiates a new HTTY::CLI with the specified _command_line_arguments_.
  def initialize(command_line_arguments)
    handle_version(command_line_arguments)
    handle_help(command_line_arguments)
    initialize_session(command_line_arguments)
  end

  # Takes over STDIN, STDOUT, and STDERR to expose #session to command-line
  # interaction.
  def run!
    say_hello
    catch :quit do
      HTTY::CLI::InputDevice.new(self).commands do |command_line|
        run_command_line(command_line)
      end
    end
    say_goodbye
  end

  # This is something like should belong to Display
  def visualize_prompt(message = '')
    print prompt(@session.requests.last) + message
  end

private

  def run_command_line(command_line)
    command = HTTY::CLI::Commands.build_for command_line, :session => @session

    unless command
      STDERR.puts notice('Unrecognized command')
      puts notice(
        'Try typing ' + strong(HTTY::CLI::Commands::Help.command_line)
      )
      return
    end

    if command == :unclosed_quote
      STDERR.puts notice('Unclosed quoted expression -- try again')
      return
    end

    if ARGV.include?('--debug')
      command.perform
    else
      rescuing_from Exception do
        command.perform
      end
    end
  end

  def handle_version(command_line_arguments)
    if command_line_arguments.include?('--version')
      puts "v#{HTTY::VERSION}"
      exit
    end
  end

  def handle_help(command_line_arguments)
    if command_line_arguments.include?('--help')
      HTTY::CLI::Commands::Help.new.perform
      exit
    end
  end

  def initialize_session(command_line_arguments)
    exit unless @session = rescuing_from(ArgumentError) do
      everything_but_options = command_line_arguments.reject do |a|
        a[0..0] == '-'
      end
      HTTY::Session.new(everything_but_options.first)
    end
  end
end



Dir.glob "#{File.dirname __FILE__}/cli/*.rb" do |f|
  require File.expand_path(
    "#{File.dirname __FILE__}/cli/" + File.basename(f, '.rb')
  )
end
