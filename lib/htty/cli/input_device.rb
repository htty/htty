require 'readline'

module HTTY::CLI::InputDevice
  def self.new(display)
    if STDIN.tty?
      TTY.new(display)
    else
      Pipe.new(display)
    end
  end

  class Pipe
    def initialize(display)
      @display = display
    end

    def commands
      STDIN.each_line do |command_line|
        command_line.chomp!
        command_line.strip!
        next if command_line.empty?
        @display.visualize_prompt(command_line + "\n")
        yield command_line
      end
    end
  end

  class TTY
    def initialize(display)
      enable_completion
      @display = display
    end

    def commands
      loop do
        begin
          command_line = ''
          while command_line.empty? do
            @display.visualize_prompt
            if (command_line = Readline.readline('', true)).nil?
              raise Interrupt
            end
            if whitespace?(command_line) || repeat?(command_line)
              Readline::HISTORY.pop
            end
            command_line.chomp!
            command_line.strip!
          end
          yield command_line
        rescue Interrupt
          puts
          throw :quit
        end
      end
    end

    private

    def enable_completion
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
  end
end
