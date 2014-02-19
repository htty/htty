require File.expand_path("#{File.dirname __FILE__}/display")
require File.expand_path("#{File.dirname __FILE__}/../uri")

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
        HTTY::URI.escape_component(a)
      end
    end
  end

end
