require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/version")

RSpec.describe HTTY do
  it 'should have a version constant of the expected format' do
    expect(HTTY::VERSION).to match( /^\d+\.\d+\.\d+/ )
  end
end
