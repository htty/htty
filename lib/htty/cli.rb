require 'readline'
require File.expand_path("#{File.dirname __FILE__}/cli/commands")
require File.expand_path("#{File.dirname __FILE__}/cli/commands/help")
require File.expand_path("#{File.dirname __FILE__}/cli/commands/quit")
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
    if command_line_arguments.include?('--version')
      puts "v#{HTTY::VERSION}"
      exit
    end

    if command_line_arguments.include?('--help')
      HTTY::CLI::Commands::Help.new.perform
      exit
    end

    exit unless @session = rescuing_from(ArgumentError) do
      everything_but_options = command_line_arguments.reject do |a|
        a[0..0] == '-'
      end
      HTTY::Session.new(everything_but_options.first)
    end

    register_completion_proc
  end

  # Takes over stdin, stdout, and stderr to expose #session to command-line
  # interaction.
  def run!
    say_hello

    catch :quit do
      loop do
        begin
          unless (command = prompt_for_command)
            $stderr.puts notice('Unrecognized command')
            puts notice('Try typing ' +
                        strong(HTTY::CLI::Commands::Help.command_line))
            next
          end

          if command == :unclosed_quote
            $stderr.puts notice('Unclosed quoted expression -- try again')
            next
          end

          if ARGV.include?('--debug')
            command.perform
          else
            rescuing_from Exception do
              command.perform
            end
          end
        rescue Interrupt
          puts
          throw :quit
        end
      end
    end

    say_goodbye
  end

private

  def prompt_for_command
    command_line = ''
    while command_line.empty? do
      prompt = prompt(session.requests.last)
      print prompt
      if (command_line = Readline.readline('', true)).nil?
        raise Interrupt
      end
      if whitespace?(command_line) || repeat?(command_line)
        Readline::HISTORY.pop
      end
      command_line.chomp!
      command_line.strip!
    end
    HTTY::CLI::Commands.build_for command_line, :session => session
  end

  def register_completion_proc
    Readline.completion_proc = proc do |input|
      autocomplete_list = HTTY::CLI::Commands.select do |c|
        c.complete_for? input
      end
      autocomplete_list.collect(&:raw_name)
    end
  end

  def repeat?(command_line)
    command_line == Readline::HISTORY.to_a[-2]
  end

  def whitespace?(command_line)
    command_line.strip.empty?
  end

  def register_completion_proc
    Readline.completion_proc = proc do |input|
      if Readline.respond_to?("line_buffer")
        if !Readline.line_buffer.include? " " or Readline.line_buffer[0..4] == "help "
          command_auto_complete(input)
        else # Try to auto-complete parameters for a command
          completion_values = []
          HTTY::CLI::Commands.each do |c|
            command_name = c.raw_name
            if Readline.line_buffer[0..command_name.length-1] == command_name
              command_line = Readline.line_buffer.chomp.strip
              command_instance = HTTY::CLI::Commands.build_for command_line, :session => session
              completion_values = command_instance.completion_options_for_arguments
              break
            end
          end
          completion_values
        end
      else
        command_auto_complete(input)
      end
    end
  end

  def command_auto_complete(input)
    auto_complete_list = HTTY::CLI::Commands.select do |c|
      c.can_auto_complete_for(input)
    end
    auto_complete_list.collect do |c|
      c.raw_name
    end
  end

end

Dir.glob "#{File.dirname __FILE__}/cli/*.rb" do |f|
  require File.expand_path("#{File.dirname __FILE__}/cli/" +
                           File.basename(f, '.rb'))
end
