require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/session")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/multipart_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/multipart")
require 'pathname'

test_file = Pathname.new("#{File.dirname __FILE__}/fixtures/file.dat")

describe HTTY::CLI::Commands::MultipartSet do
  let :klass do
    subject.class
  end

  let :session do
    HTTY::Session.new nil
  end

  def instance(*arguments)
    klass.new :session => session, :arguments => arguments
  end

  describe 'with one argument' do
    it 'should assign a single string valuess part ' do
      instance('test').perform
      session.requests.last.body.should == "--httyboundary12345\r\nContent-Disposition: form-data;"+
        " name=\"test\";\r\n\r\n\r\n--#{HTTY::Multipart::BOUNDARY}--\r\n" 
    end
  end

  describe 'with two arguments' do
    it 'should assign a string part' do
      instance('foo', 'bar').perform
      session.requests.last.body.should == "--httyboundary12345\r\nContent-Disposition: form-data;"+
        " name=\"foo\";\r\n\r\nbar\r\n--#{HTTY::Multipart::BOUNDARY}--\r\n"
    end
  end

  describe 'with file part' do
    it 'should assign a file paty ' do
      instance('foo', "file:#{test_file}").perform
      session.requests.last.body.should == "--httyboundary12345\r\n"+"Content-Disposition: form-data; name=\"foo\"; " +
      "filename=\"file.dat\"\r\nContent-Type: text/plain\r\n\r\nTest data\n\r\n" + 
      "--#{HTTY::Multipart::BOUNDARY}--\r\n"
    end
  end
 
  describe 'with file part and string part' do
    it 'should assign two parts' do
      instance('foo', 'bar', 'test_file', "file:#{test_file}").perform
      session.requests.last.body.should == "--httyboundary12345\r\nContent-Disposition: form-data;"+
      " name=\"foo\";\r\n\r\nbar\r\n"                                                              +
      "--httyboundary12345\r\n"+"Content-Disposition: form-data; name=\"test_file\"; "             +
      "filename=\"file.dat\"\r\nContent-Type: text/plain\r\n\r\nTest data\n\r\n"                   + 
      "--#{HTTY::Multipart::BOUNDARY}--\r\n"
 
    end
  end

  describe 'with duplicate parts' do
    it 'should replace existing part' do
      session.requests.last.body_set "--httyboundary12345\r\nContent-Disposition: form-data;"+
        " name=\"foo\";\r\n\r\nbar\r\n--#{HTTY::Multipart::BOUNDARY}--\r\n"
      instance('foo', 'bar', 'foo', 'test').perform
      session.requests.last.body.should ==  "--httyboundary12345\r\nContent-Disposition: form-data;"+
        " name=\"foo\";\r\n\r\ntest\r\n--#{HTTY::Multipart::BOUNDARY}--\r\n"
    end
  describe "with same part"
    it 'should remain only one of the same parts' do
      instance('foo', 'bar', 'foo', 'bar').perform
      session.requests.last.body.should ==  "--httyboundary12345\r\nContent-Disposition: form-data;"+
        " name=\"foo\";\r\n\r\nbar\r\n--#{HTTY::Multipart::BOUNDARY}--\r\n"
    end
  end
end
