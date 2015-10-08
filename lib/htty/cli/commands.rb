require 'htty'

# Contains classes that implement commands in the user interface.
module HTTY::CLI::Commands

  autoload :Address,            'htty/cli/commands/address'
  autoload :BodyClear,          'htty/cli/commands/body_clear'
  autoload :BodyEdit,           'htty/cli/commands/body_edit'
  autoload :BodyRequest,        'htty/cli/commands/body_request'
  autoload :BodyRequestOpen,    'htty/cli/commands/body_request_open'
  autoload :BodyResponse,       'htty/cli/commands/body_response'
  autoload :BodyResponseOpen,   'htty/cli/commands/body_response_open'
  autoload :BodySet,            'htty/cli/commands/body_set'
  autoload :BodyUnset,          'htty/cli/commands/body_unset'
  autoload :Cd,                 'htty/cli/commands/cd'
  autoload :CookieAdd,          'htty/cli/commands/cookie_add'
  autoload :CookieRemove,       'htty/cli/commands/cookie_remove'
  autoload :Cookies,            'htty/cli/commands/cookies'
  autoload :CookiesAdd,         'htty/cli/commands/cookies_add'
  autoload :CookiesClear,       'htty/cli/commands/cookies_clear'
  autoload :CookiesRemove,      'htty/cli/commands/cookies_remove'
  autoload :CookiesRemoveAll,   'htty/cli/commands/cookies_remove_all'
  autoload :CookiesUse,         'htty/cli/commands/cookies_use'
  autoload :Delete,             'htty/cli/commands/delete'
  autoload :Exit,               'htty/cli/commands/exit'
  autoload :Follow,             'htty/cli/commands/follow'
  autoload :Form,               'htty/cli/commands/form'
  autoload :FormAdd,            'htty/cli/commands/form_add'
  autoload :FormClear,          'htty/cli/commands/form_clear'
  autoload :FormRemove,         'htty/cli/commands/form_remove'
  autoload :FormRemoveAll,      'htty/cli/commands/form_remove_all'
  autoload :FragmentClear,      'htty/cli/commands/fragment_clear'
  autoload :FragmentSet,        'htty/cli/commands/fragment_set'
  autoload :FragmentUnset,      'htty/cli/commands/fragment_unset'
  autoload :Get,                'htty/cli/commands/get'
  autoload :HeaderSet,          'htty/cli/commands/header_set'
  autoload :HeaderUnset,        'htty/cli/commands/header_unset'
  autoload :HeadersClear,       'htty/cli/commands/headers_clear'
  autoload :HeadersRequest,     'htty/cli/commands/headers_request'
  autoload :HeadersResponse,    'htty/cli/commands/headers_response'
  autoload :HeadersSet,         'htty/cli/commands/headers_set'
  autoload :HeadersUnset,       'htty/cli/commands/headers_unset'
  autoload :HeadersUnsetAll,    'htty/cli/commands/headers_unset_all'
  autoload :Help,               'htty/cli/commands/help'
  autoload :History,            'htty/cli/commands/history'
  autoload :HistoryVerbose,     'htty/cli/commands/history_verbose'
  autoload :HostSet,            'htty/cli/commands/host_set'
  autoload :HttpDelete,         'htty/cli/commands/http_delete'
  autoload :HttpGet,            'htty/cli/commands/http_get'
  autoload :HttpHead,           'htty/cli/commands/http_head'
  autoload :HttpOptions,        'htty/cli/commands/http_options'
  autoload :HttpPatch,          'htty/cli/commands/http_patch'
  autoload :HttpPost,           'htty/cli/commands/http_post'
  autoload :HttpPut,            'htty/cli/commands/http_put'
  autoload :HttpTrace,          'htty/cli/commands/http_trace'
  autoload :Patch,              'htty/cli/commands/patch'
  autoload :PathSet,            'htty/cli/commands/path_set'
  autoload :PortSet,            'htty/cli/commands/port_set'
  autoload :Post,               'htty/cli/commands/post'
  autoload :Put,                'htty/cli/commands/put'
  autoload :QueryAdd,           'htty/cli/commands/query_add'
  autoload :QueryClear,         'htty/cli/commands/query_clear'
  autoload :QueryRemove,        'htty/cli/commands/query_remove'
  autoload :QuerySet,           'htty/cli/commands/query_set'
  autoload :QueryUnset,         'htty/cli/commands/query_unset'
  autoload :QueryUnsetAll,      'htty/cli/commands/query_unset_all'
  autoload :Quit,               'htty/cli/commands/quit'
  autoload :Reuse,              'htty/cli/commands/reuse'
  autoload :SchemeSet,          'htty/cli/commands/scheme_set'
  autoload :SslVerification,    'htty/cli/commands/ssl_verification'
  autoload :SslVerificationOff, 'htty/cli/commands/ssl_verification_off'
  autoload :SslVerificationOn,  'htty/cli/commands/ssl_verification_on'
  autoload :Status,             'htty/cli/commands/status'
  autoload :Undo,               'htty/cli/commands/undo'
  autoload :UserinfoClear,      'htty/cli/commands/userinfo_clear'
  autoload :UserinfoSet,        'htty/cli/commands/userinfo_set'
  autoload :UserinfoUnset,      'htty/cli/commands/userinfo_unset'

  extend Enumerable

  # Returns a HTTY::CLI::Command descendant whose command line representation
  # matches the specified _command_line_. If an _attributes_ hash is specified,
  # it is used to initialize the command.
  def self.build_for(command_line, attributes={})
    each do |klass|
      if (command = klass.build_for(command_line, attributes))
        return command
      end
    end
    nil
  end

  # Yields each HTTY::CLI::Command descendant in turn.
  def self.each
    Dir.glob "#{File.dirname __FILE__}/commands/*.rb" do |f|
      class_name = File.basename(f, '.rb').gsub(/^(.)/, &:upcase).
                                           gsub(/_(\S)/) do |initial|
        initial.gsub(/_/, '').upcase
      end
      klass = const_get(class_name) rescue nil
      yield klass if klass
    end
    self
  end

end
