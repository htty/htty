require 'mime/types'
require File.expand_path("#{File.dirname __FILE__}/../platform")
require File.expand_path("#{File.dirname __FILE__}/../tempfile_preserving_extname")
require File.expand_path("#{File.dirname __FILE__}/display")

module HTTY; end

class HTTY::CLI; end

# Encapsulates behavior common to all HTTY::CLI::Command subclasses that open
# body content in an external viewer program.
module HTTY::CLI::BodyOpenCommand

  module ClassMethods

    # Returns the arguments for the command-line usage of the command.
    def command_line_arguments
      '[OPTIONS]'
    end

    # Returns the extended help text for the command.
    def help_extended
      "#{help_extended_preamble}\n"                                            +
      "\n"                                                                     +
      'The shell command used to launch the program is platform-specific. On ' +
      "Windows, the 'start' command is used. On other platforms, the 'open' "  +
      "command is used. (The 'open' command may not be available on your "     +
      "system.)\n"                                                             +
      "\n"                                                                     +
      'You may specify options to be passed to the program. For example, on '  +
      'Mac OS X, your default program for HTML files may be Google Chrome, '   +
      'but you can launch Firefox instead by typing '                          +
      "#{strong command_line + ' -a firefox'}. Likewise, on Windows your "     +
      'default program for HTML files may be Internet Explorer, but you can '  +
      "launch Opera instead by typing #{strong command_line + ' opera'}."
    end

  end

  def self.included(other_module)
    other_module.extend ClassMethods
    other_module.module_eval do
      include HTTY::CLI::Display
    end
 end

private

  def open(payload)
    if (body = payload.body).to_s.empty?
      puts notice("#{payload.class.name.split('::').last} does not have a body")
      return self
    end
    content_type_header = payload.headers.detect do |name, value|
      name == 'Content-Type'
    end
    content_type = content_type_header ? content_type_header.last : nil
    tempfile = render_to_file(body, content_type)
    path = platform_path(tempfile.path)
    arguments_to_open = arguments.empty? ? '' : " #{arguments.join ' '}"
    `#{open_command}#{arguments_to_open} #{path}`
  end

  def open_command
    HTTY::Platform.windows? ? 'start' : 'open'
  end

  def platform_path(path)
    HTTY::Platform.windows? ? path.gsub('/', '\\') : path
  end

  def render_to_file(body, content_type)
    filename = "htty.#{tempfile_extension content_type}"
    HTTY::TempfilePreservingExtname.new(filename).tap do |f|
      f.write body
      f.close
    end
  end

  def tempfile_extension(content_type)
    unless (types = MIME::Types[content_type].first)
      if content_type.to_s.empty?
        puts notice("No 'Content-Type' header value -- assuming 'text/html'")
      else
        puts notice("Unrecognized 'Content-Type' header value " +
                    "'#{content_type}' -- using 'text/html' instead")
      end
      return 'html'
    end
    types.extensions.first
  end

end
