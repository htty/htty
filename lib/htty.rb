# Contains the implementation of _htty_.
module HTTY; end

Dir.glob "#{File.dirname __FILE__}/htty/*.rb" do |f|
  require File.expand_path("#{File.dirname __FILE__}/htty/" +
                           File.basename(f, '.rb'))
end
