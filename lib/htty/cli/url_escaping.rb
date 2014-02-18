require 'uri'
require File.expand_path("#{File.dirname __FILE__}/display")

module HTTY; end

class HTTY::CLI; end

# Encapsulates the URL escaping logic of _htty_'s command-line interface.
module HTTY::CLI::UrlEscaping

  include HTTY::CLI::Display

  def self.escape_or_warn_of_escape_sequences(arguments)
    arguments.collect do |a|
      if a =~ /%[0-9a-f]{2}/i
        say "Argument '#{a}' was not URL-escaped because it contains escape " +
            'sequences'
        a
      else
        # There's a lot of confusion about this, the default implementation
        # of URI.escape is marked as "obsolete", CGI.escape does another work,
        # a safe solution seems to use https://github.com/sporkmonger/addressable
        # without adding a new dependecy I found that encode all not unreserved
        # characters (unfortunately that doesn't mean all reserved characters) it's
        # a pretty safe solution, see http://tools.ietf.org/html/rfc3986#section-2.3
        URI.escape(a, /[^-_.~a-zA-Z0-9]/)
      end
    end
  end

  def escape_or_warn_of_escape_sequences(arguments)
    HTTY::CLI::UrlEscaping.escape_or_warn_of_escape_sequences(arguments)
  end

end
