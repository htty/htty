require 'spec'
require File.expand_path("#{File.dirname __FILE__}/../../lib/htty")

describe HTTY do
  it 'should have a version constant of the expected format' do
    HTTY::VERSION.should =~ /^\d+\.\d+\.\d+/
  end
end
