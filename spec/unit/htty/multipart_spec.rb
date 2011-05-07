require 'rspec'
require 'pathname'
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/request")
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/session")

test_file = Pathname.new("#{File.dirname __FILE__}/../../integration/htty/cli/commands/fixtures/file.dat")

describe HTTY::Multipart do
  
  let :session do
    HTTY::Session.new nil
  end

  before :each do
    subject.multipart_set!(session.requests.last)
  end
  
  context 'miltipartable' do
    it 'should make request multipartable' do
      session.requests.last.should respond_to(:multipart)
     session.requests.last.should respond_to(:body_update)
    end

    it 'should unset all changes' do
     HTTY::Multipart.multipart_unset!(session.requests.last) 
     session.requests.last.should_not respond_to(:multipart)
     session.requests.last.should_not respond_to(:body_update)
     session.requests.last.body.should be_nil
     session.requests.last.headers.should_not include("Content-Length")
    end
  end
  
  context HTTY::Multipart::StringPart do
    
    let :string_part do
      subject::StringPart
    end
    
    it 'should return correct multipart body' do
      sp = string_part.new('foo','bar')
      expected = "Content-Disposition: form-data; name=\"foo\";\r\n\r\nbar\r\n"

      sp.to_multipart.should == expected
    end
  end
  context HTTY::Multipart::FilePart do
    
    let :file_part do
      subject::FilePart
    end
    
    it 'should return correct multipart body' do
      fp = file_part.new('foo',test_file)
      expected = "Content-Disposition: form-data; name=\"foo\"; " +
      "filename=\"file.dat\"\r\nContent-Type: text/plain\r\n\r\nTest data\n\r\n"
       fp.to_multipart.should == expected
    end
  end

end
