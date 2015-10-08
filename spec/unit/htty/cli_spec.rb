require 'htty/cli'
require 'htty/request'

RSpec.describe HTTY::CLI do
  describe 'with empty arguments' do
    let :cli do
      HTTY::CLI.new([])
    end

    it 'should have a session with the URI http://0.0.0.0:80/' do
      expect(cli.session.requests).to eq([HTTY::Request.new('http://0.0.0.0:80/')])
    end
  end

  describe 'with an address argument' do
    let :cli do
      HTTY::CLI.new(%w(https://njonsson@github.com/njonsson/htty))
    end

    it 'should have a session with a URI corresponding to the address' do
      expect(cli.session.requests).to eq([HTTY::Request.new('https://'            +
                                                            'njonsson@github.com' +
                                                            ':443'                +
                                                            '/njonsson/htty')])
    end
  end
end
