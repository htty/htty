# Defines HTTY::CLI::CookieClearingCommand.

require File.expand_path("#{File.dirname __FILE__}/display")

module HTTY; end

class HTTY::CLI; end

# Encapsulates behavior common to all HTTY::CLI::Command subclasses that can
# result in cookies being cleared automatically.
module HTTY::CLI::CookieClearingCommand

  include HTTY::CLI::Display

protected

  def notify_if_cookies_cleared(request)
    had_cookies = !request.cookies.empty?
    new_request = yield
    if (had_cookies && new_request.cookies.empty?)
      puts notice('Cookies cleared')
    end
    new_request
  end

end
