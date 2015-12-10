require 'net/http'

# Contains the implementation of _htty_.
module HTTY

  autoload :CLI,                       'htty/cli'
  autoload :CookiesUtil,               'htty/cookies_util'
  autoload :Headers,                   'htty/headers'
  autoload :NoHeaderError,             'htty/no_header_error'
  autoload :NoLocationHeaderError,     'htty/no_location_header_error'
  autoload :NoResponseError,           'htty/no_response_error'
  autoload :NoSetCookieHeaderError,    'htty/no_set_cookie_header_error'
  autoload :Payload,                   'htty/payload'
  autoload :Platform,                  'htty/platform'
  autoload :Preferences,               'htty/preferences'
  autoload :Request,                   'htty/request'
  autoload :RequestsUtil,              'htty/requests_util'
  autoload :Response,                  'htty/response'
  autoload :Session,                   'htty/session'
  autoload :TempfilePreservingExtname, 'htty/tempfile_preserving_extname'
  autoload :URI,                       'htty/uri'
  autoload :VERSION,                   'htty/version'

end

module Net

  class HTTP < Protocol

    autoload :Patch, 'htty/http_patch'

  end

end
