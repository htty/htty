require File.expand_path("#{File.dirname __FILE__}/../../no_response_error")
require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/body_request")
require File.expand_path("#{File.dirname __FILE__}/headers_response")
require File.expand_path("#{File.dirname __FILE__}/status")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _body-response_ command.
class HTTY::CLI::Commands::BodyResponse < HTTY::CLI::Command

  # Returns the name of a category under which help for the _body_ command
  # should appear.
  def self.category
    'Inspecting Responses'
  end

  # Returns the string used to invoke the _body-response_ command from the
  # command line.
  def self.command_line
    'body[-response]'
  end

  # Returns the help text for the _body-response_ command.
  def self.help
    'Displays the body of the response'
  end

  # Returns the extended help text for the _body-response_ command.
  def self.help_extended
    'Displays the body content received in the response. Does not ' +
    'communicate with the host.'
  end

  # Returns related command classes for the _body-response_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::HeadersResponse,
     HTTY::CLI::Commands::Status,
     HTTY::CLI::Commands::BodyRequest]
  end

  # Performs the _body-response_ command.
  def perform
    unless (response = session.last_response)
      raise HTTY::NoResponseError
    end
    unless (body = response.body).to_s.empty?
      if arguments.include?('open')
        open(body)
      else
        puts body
      end
    end
    self
  end

  private

  def open(body)
    require 'launchy'
    page = render(body)
    Launchy::Browser.run "file://#{page.path}"
    page.close
  rescue LoadError
    warn 'Sorry, you need to install launchy to open pages: `gem install launchy`'
  end

  def render(body)
    TempHTML.new("htty-#{Time.new.strftime("%Y%m%d%H%M%S")}.html").tap do |file|
      file.write(body) and file.rewind
    end
  end

end

# Tempfile won't let you set a meaningful extension.
require 'tempfile'
class TempHTML < Tempfile
  def make_tmpname(basename, n)
    # force tempfile to use basename's extension
    extension = File::extname(basename)
    # force hyphens instead of periods in name
    sprintf('%s%d-%d%s', File::basename(basename, extension), $$, n, extension)
  end
end
