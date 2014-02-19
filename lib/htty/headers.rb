require 'uri'
require 'base64'

module HTTY; end

class HTTY::Headers
  def self.basic_authentication_for(username, password = nil)
    ['Authorization',
     'Basic ' + Base64.encode64(
       URI.unescape([username, password].compact.join(':'))
      ).chomp
    ]
  end

  def self.credentials_from(basic_authentication)
    if match = /^Basic (.+)$/.match(basic_authentication)
      credentials = Base64.decode64(match[1]).split(':')
      return yield *credentials if block_given?
      return credentials
    end
  end
end
