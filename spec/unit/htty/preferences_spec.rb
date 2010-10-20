require 'spec'
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/preferences")

describe HTTY::Preferences do
  it 'should maintain current preferences' do
    HTTY::Preferences.current.should be_equal(HTTY::Preferences.current)
  end
end
