require 'uri'

module HTTY; end

class HTTY::URI
  # There's a lot of confusion about this, the default implementation
  # of URI.escape is marked as "obsolete", CGI.escape does another work,
  # a safe solution seems to use https://github.com/sporkmonger/addressable
  # without adding a new dependecy I found that encode all not unreserved
  # characters (unfortunately that doesn't mean all reserved characters) it's
  # a pretty safe solution, see http://tools.ietf.org/html/rfc3986#section-2.3
  # URI.escape(a, /[^-_.~a-zA-Z0-9]/)
  def self.escape_component(component)
    URI.escape(component, /[^-_.~a-zA-Z0-9]/) unless component.nil?
  end
end
