require 'spec'
require File.expand_path("#{File.dirname __FILE__}/../../../app/htty/cli")
require File.expand_path("#{File.dirname __FILE__}/../../../app/htty/request")

describe HTTY::CLI do
  describe 'with empty arguments' do
    before :each do
      @cli = HTTY::CLI.new([])
    end

    it 'should have a session with the URI http://0.0.0.0:80/' do
      @cli.session.requests.should == [HTTY::Request.new('http://0.0.0.0:80/')]
    end
  end

  describe 'with an address argument' do
    before :each do
      @cli = HTTY::CLI.new(%w(http://njonsson@github.com/njonsson/htty))
    end

    it 'should have a session with a URI corresponding to the address' do
      @cli.session.requests.should == [HTTY::Request.new('http://'             +
                                                         'njonsson@github.com' +
                                                         '/njonsson/htty')]
    end
  end
end
