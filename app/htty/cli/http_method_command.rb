# Defines HTTY::CLI::HTTPMethodCommand.

require File.expand_path("#{File.dirname __FILE__}/../request")
require File.expand_path("#{File.dirname __FILE__}/display")
require File.expand_path("#{File.dirname __FILE__}/commands/cookies_use")
# This 'require' statement leads to an unresolvable circular dependency.
# require File.expand_path("#{File.dirname __FILE__}/commands/follow")

module HTTY; end

class HTTY::CLI; end

# Encapsulates behavior common to all HTTP-method-oriented HTTY::CLI::Command
# subclasses.
module HTTY::CLI::HTTPMethodCommand

  include HTTY::CLI::Display

  # Returns the name of a category under which help for the _http-get_ command
  # should appear.
  def self.category
    'Issuing Requests'
  end

  # Performs the command.
  def perform
    add_request_if_has_response do |request|
      request = request.send("#{method}!", *arguments)
      unless body? || request.body.to_s.empty?
        puts notice("The body of your #{method.upcase} request is not being " +
                    'sent')
      end
      notify_if_cookies
      notify_if_follow
      request
    end
    show_response session.last_response
    self
  end

private

  # Returns true if the command sends the request body.
  def body?
    HTTY::Request::METHODS_SENDING_BODY.include? method
  end

  def method
    self.class.name.split('::').last.gsub(/^http/i, '').downcase.to_sym
  end

  def notify_if_cookies
    request  = session.requests.last
    response = session.last_response
    unless response.cookies.empty? || (request.cookies == response.cookies)
      puts notice('Type ' +
                  "#{strong HTTY::CLI::Commands::CookiesUse.command_line} to " +
                  'use cookies offered in the response')
    end
    self
  end

  def notify_if_follow
    location_header = session.last_response.headers.detect do |header|
      header.first == 'Location'
    end
    if location_header
      puts notice('Type ' +
                  "#{strong HTTY::CLI::Commands::Follow.command_line} to " +
                  "follow the 'Location' header received in the response")
    end
    self
  end

end
