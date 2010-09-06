# Loads constants defined within HTTY.

# Contains the implementation of _htty_.
module HTTY

  # The version of this release of _htty_.
  VERSION = File.read("#{File.dirname __FILE__}/../VERSION").chomp

end

Dir.glob "#{File.dirname __FILE__}/htty/*.rb" do |f|
  require File.expand_path("#{File.dirname __FILE__}/htty/" +
                           File.basename(f, '.rb'))
end
