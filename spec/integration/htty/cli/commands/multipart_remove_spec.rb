require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/session")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/multipart_remove")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/multipart_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/multipart")

describe HTTY::CLI::Commands::MultipartRemove do
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

  describe 'with two parts' do
    it 'should remain only one' do
     instance('test').perform
     session.requests.last.body.should == "--httyboundary12345\r\nContent-Disposition: form-data;"+
        " name=\"foo\";\r\n\r\nbar\r\n--#{HTTY::Multipart::BOUNDARY}--\r\n"

    end
  end

end
