require 'htty/version'

RSpec.describe HTTY::VERSION do
  it 'should have a version constant of the expected format' do
    expect(HTTY::VERSION).to match( /^\d+\.\d+\.\d+/ )
  end
end
