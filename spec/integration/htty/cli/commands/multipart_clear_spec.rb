require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/session")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/multipart_clear")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/multipart_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/multipart")

describe HTTY::CLI::Commands::MultipartClear do
  let :klass do
    subject.class
  end

  let :session do
    HTTY::Session.new nil
  end

  def instance(*arguments)
    klass.new :session => session, :arguments => arguments
  end

  before :each do
    set = HTTY::CLI::Commands::MultipartSet.new :session => session, :arguments => ['foo','bar','test','value']
    set.perform
  end

  describe 'request body after clear' do
    it 'should be empty ' do
     instance.perform
     session.requests.last.body.should be_nil
    end
  end

  describe 'request after clear' do
    it 'should not be multipart ' do
     instance.perform
     HTTY::Multipart.multipart?(session.requests.last).should be_false
    end
  end

end
