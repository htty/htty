# Defines HTTY::CLI::UrlEscaping.

require 'uri'
require File.expand_path("#{File.dirname __FILE__}/display")

module HTTY; end

class HTTY::CLI; end

# Encapsulates the URL escaping logic of _htty_'s command-line interface.
module HTTY::CLI::UrlEscaping

  include HTTY::CLI::Display

  def escape_or_warn_of_escape_sequences(arguments)
    arguments.collect do |a|
      if a =~ /%[0-9a-f]{2}/i
        say "Argument '#{a}' was not URL-escaped because it contains escape " +
            'sequences'
        a
      else
        URI.escape a
      end
    end
  end

end
