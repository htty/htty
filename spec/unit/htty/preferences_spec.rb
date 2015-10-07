require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/preferences")

RSpec.describe HTTY::Preferences do
  it 'should maintain current preferences' do
    expect(HTTY::Preferences.current).to eq(HTTY::Preferences.current)
  end
end
