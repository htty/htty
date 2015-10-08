require 'autoloaded'

# Contains the implementation of _htty_.
module HTTY

  ::Autoloaded.module do |autoloaded|
    autoloaded.with :CLI, :URI, :VERSION
  end

end

module Net

  class HTTP

    autoload :Patch, 'htty/http_patch'

  end

end
