require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/version")

describe HTTY do
  it 'should have a version constant of the expected format' do
    HTTY::VERSION.should =~ /^\d+\.\d+\.\d+/
  end
end
