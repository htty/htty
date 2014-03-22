require 'tempfile'
require File.expand_path("#{File.dirname __FILE__}/../command")
require File.expand_path("#{File.dirname __FILE__}/../display")
require File.expand_path("#{File.dirname __FILE__}/body_request")
require File.expand_path("#{File.dirname __FILE__}/body_unset")
require File.expand_path("#{File.dirname __FILE__}/body_set")

module HTTY; end

class HTTY::CLI; end

module HTTY::CLI::Commands; end

# Encapsulates the _body-edit_ command.
class HTTY::CLI::Commands::BodyEdit < HTTY::CLI::Command

  include HTTY::CLI::Display

  # Returns the name of a category under which help for the _body-edit_ command
  # should appear.
  def self.category
    'Building Requests'
  end

  # Returns the help text for the _body-edit_ command.
  def self.help
    'Sets the body of the request using a text editor'
  end

  # Returns the extended help text for the _body-edit_ command.
  def self.help_extended
    <<-EOH.gsub(/^(?: |\t)+/, '')
    Sets the body content used for the request. Does not communicate with
    the host.

    Uses the editor specified in EDITOR environment variable. Your editor will
    open with a temporary file, fill the file with the request body. When you
    are done save the file and quit the editor. The exact content of the
    temporary file will be used as the request body. The temporary file will be
    removed after this command.

    If you want to choose your editor, start htty with `EDITOR=vim htty`
    replacing 'vim' with your editor of choice.
    EOH
  end

  # Returns related command classes for the _body-edit_ command.
  def self.see_also_commands
    [ HTTY::CLI::Commands::BodyRequest,
      HTTY::CLI::Commands::BodyUnset,
      HTTY::CLI::Commands::BodySet
    ]
  end

  # Performs the _body-edit_ command.
  def perform
    add_request_if_new do |request|
      request.body_set(with_editor do |editor|
        file = Tempfile.new('htty')
        if last_request_body = session.requests.last.body
          File.open(file.path, 'w+') {|f| f.write(last_request_body)}
        end
        result = system(editor + ' ' + file.path)
        if not result
          return empty_body_because("Unable to use '#{editor}' to edit request's body")
        end
        body = File.read(file.path)
        file.unlink
        body
      end)
    end
  end

  private

  def with_editor
    editor = ENV['EDITOR']
    if editor.nil? || editor.empty?
      return empty_body_because('EDITOR environment variable is not set.')
    end
    yield editor
  end

  def empty_body_because(reason)
    puts notice(reason)
    puts notice("See 'help body-edit' for further informations.")
    empty_body = ''
  end
end
