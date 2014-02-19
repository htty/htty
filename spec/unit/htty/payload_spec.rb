require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/payload")


describe HTTY::Payload do
  before(:all) do
    @bare_payload = Class.new(HTTY::Payload)
  end

  let(:body) {nil}
  let(:headers) {[['Accept', 'application/json']]}

  subject {@bare_payload.new({:body => body, :headers => headers})}

  it 'should heave headers' do
    subject.should have(1).headers
  end

  describe '.headers(key)' do
    it 'should be case insensitive' do
      subject.headers_with_key('Accept').should == [['Accept', 'application/json']]
      subject.headers_with_key('Accept').should == subject.headers_with_key('accept')
    end
  end

  describe '.header(key)' do
    it 'should return the header with a given key' do
      subject.header('Accept').should == 'application/json'
    end

    it 'should return the header with a given key ignoring the case' do
      ['Accept', 'ACCEPT', 'accept', 'AccEpT'].each do |key|
        subject.header(key).should == 'application/json'
      end
    end

    context 'when key is not found' do
      it 'should raise an exception' do
        expect do
          subject.header('not-found-key')
        end.to raise_error(HTTY::NoHeaderError)
      end

      context 'when given a value as second parameter' do
        it 'should return the default value' do
          subject.header('not-found-key', :default).should == :default
        end
      end

      context 'when given an exception' do
        it 'should raise that exception' do
          exception_to_raise = Exception.new('key not found')
          expect do
            subject.header('not-found-key', exception_to_raise)
          end.to raise_error(exception_to_raise.class)
        end
      end
    end
  end
end
