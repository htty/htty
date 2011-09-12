require 'abbrev'
require 'shellwords'
require File.expand_path("#{File.dirname __FILE__}/display")

module HTTY; end

class HTTY::CLI; end

# A base class for all HTTY::CLI::Commands.
class HTTY::CLI::Command

  extend HTTY::CLI::Display

  # Returns a command that the command is an alias for, otherwise +nil+.
  def self.alias_for; end

  # Returns command classes that are aliases for the command.
  def self.aliases
    namespace_siblings.select do |s|
      s.alias_for == self
    end
  end

  # Returns a new HTTY::CLI::Commands::Command if the specified _command_line_
  # references it, otherwise +nil+. If an _attributes_ hash is specified, it is
  # used to initialize the command.
  def self.build_for(command_line, attributes={})
    command_line_regexp = make_command_line_regexp
    if (match = (command_line_regexp.match(command_line)))
      all_attributes = attributes
      if (arguments = match.captures[0])
        begin
          split_arguments = arguments.strip.shellsplit
        rescue ArgumentError
          return :unclosed_quote
        end
        return new(attributes.merge(:arguments => split_arguments))
      end
      return new(attributes)
    end
    nil
  end

  # Returns the name of a category under which help for the command should
  # appear.
  def self.category
    return nil unless alias_for
    alias_for.category
  end

  # Returns the string used to invoke the command from the command line. Its
  # abbreviation is calculated to avoid collision with other commands in the
  # same module.
  def self.command_line
    my_command_line = command_line_for_class_name(name)
    other_command_lines = namespace_siblings.collect do |s|
      if s.method_defined?(:command_line)
        s.command_line
      else
        command_line_for_class_name s.name
      end
    end
    all_command_lines = [my_command_line] + other_command_lines
    all_abbrevs = Abbrev.abbrev(all_command_lines).group_by do |abbrev,
                                                                command_line|
      command_line
    end.collect do |command_line, abbrevs|
      abbrevs.sort_by do |command_line, abbrev|
        command_line
      end.first
    end
    my_abbrev = all_abbrevs.detect do |abbrev, command_line|
      command_line == my_command_line
    end.first
    my_abbrev_regexp = Regexp.new("^(#{Regexp.escape my_abbrev})(.*)$")
    my_command_line.gsub my_abbrev_regexp do
      $2.empty? ? $1 : "#{$1}[#{$2}]"
    end
  end

  # Returns the arguments for the command-line usage of the command.
  def self.command_line_arguments
    return alias_for.command_line_arguments if alias_for
    nil
  end

  # Returns +true+ if the specified _command_line_ can be autocompleted to the
  # command.
  def self.complete_for?(command_line)
    command_name = command_line_for_class_name(name)
    command_name[0...command_line.length] == command_line
  end

  # Returns the help text for the command.
  def self.help
    return "Alias for #{strong alias_for.command_line}" if alias_for
    "(Help for #{strong command_line} is not available)"
  end

  # Returns the extended help text for the _get_ command.
  def self.help_extended
    return "(Extended help for #{command_line} is not available.)" unless help
    "#{help}."
  end

  # Returns the full name of the command as it appears on the command line,
  # without abbreviations.
  def self.raw_name
    command_line_for_class_name name
  end

  # Returns related command classes for the command.
  def self.see_also_commands
    Array(alias_for)
  end

protected

  # Displays a notice if cookies are cleared on the specified _request_ in the
  # course of the block.
  def self.notify_if_cookies_cleared(request)
    had_cookies = cookies?(request)
    changed_request = yield
    puts notice('Cookies cleared') if had_cookies && !cookies?(changed_request)
    changed_request
  end

private

  def self.command_line_for_class_name(class_name)
    class_name.split('::').last.gsub(/(.)([A-Z])/, '\1-\2').downcase
  end

  def self.completion_optional(text)
    return nil if text.empty?
    char_length = (text[0..0] == '\\') ? 2 : 1
    rest = (text.length > char_length)                ?
           completion_optional(text[char_length..-1]) :
           nil
    "(?:#{text[0...char_length]}#{rest})?"
  end

  def self.cookies?(request)
    !request.cookies.empty?
  end

  def self.make_command_line_regexp
    pattern = Regexp.escape(command_line).gsub(/\\\[(.+)\\\]/) do |optional|
      completion_optional($1)
    end
    Regexp.new "^#{pattern}(\\s.+)?$", Regexp::IGNORECASE
  end

  def self.namespaces
    container = nil
    name.split('::')[0...-1].collect do |element|
      if container.nil?
        container = instance_eval("::#{element}", __FILE__, __LINE__)
      else
        container = container.module_eval(element, __FILE__, __LINE__)
      end
    end
  end

  def self.namespace_siblings
    namespace = namespaces.last
    other_commands = namespace.constants.collect do |constant|
      type = namespace.module_eval(constant.to_s, __FILE__, __LINE__)
      (type == self) ? nil : type
    end.compact
  end

public

  # Returns the arguments provided to the command.
  attr_reader :arguments

  # Returns the session within which the command operates.
  attr_reader :session

  # Initializes a new HTTY::CLI::Command with attribute values specified in the
  # _attributes_ hash.
  #
  # Valid _attributes_ keys include:
  #
  # * <tt>:arguments</tt>
  # * <tt>:session</tt>
  def initialize(attributes={})
    @arguments = Array(attributes[:arguments])
    @session   = attributes[:session]
  end

  # Performs the command, or raises NotImplementedError.
  def perform
    unless (alias_for = self.class.alias_for)
      raise NotImplementedError, 'not implemented yet'
    end
    alias_for.new(:arguments => arguments, :session => session).perform
  end

protected

  # Yields the last request in #session. If the block returns a different
  # request, it is added to the requests of #session.
  def add_request_if_new
    requests     = session.requests
    last_request = requests.last
    unless (new_request = yield(last_request)).equal?(last_request)
      requests << new_request
    end
    self
  end

end
