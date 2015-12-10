require 'autoloaded'
require 'net/http'

# Contains the implementation of _htty_.
module HTTY

  ::Autoloaded.module do |autoloaded|
    autoloaded.with :CLI, :URI, :VERSION
  end

end

module Net

  class HTTP < Protocol

    autoload :Patch, 'htty/http_patch'

  end

end
