require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/payload")

RSpec.describe HTTY::Payload do
  before(:all) do
    @bare_payload = Class.new(HTTY::Payload)
  end

  let(:body) {nil}
  let(:headers) {[['Accept', 'application/json']]}

  subject {@bare_payload.new({:body => body, :headers => headers})}

  it 'should heave headers' do
    expect(subject.headers).to eq(headers)
  end

  describe '.headers(key)' do
    it 'should be case insensitive' do
      expect(subject.headers_with_key('Accept')).to eq([%w(Accept
                                                           application/json)])
      expect(subject.headers_with_key('Accept')).to eq(subject.headers_with_key('accept'))
    end
  end

  describe '.header(key)' do
    it 'should return the header with a given key' do
      expect(subject.header('Accept')).to eq('application/json')
    end

    it 'should return the header with a given key ignoring the case' do
      ['Accept', 'ACCEPT', 'accept', 'AccEpT'].each do |key|
        expect(subject.header(key)).to eq('application/json')
      end
    end

    context 'when key is not found' do
      it 'should raise an exception' do
        expect {
          subject.header 'not-found-key'
        }.to raise_error(HTTY::NoHeaderError)
      end

      context 'when given a value as second parameter' do
        it 'should return the default value' do
          expect(subject.header('not-found-key', :default)).to eq(:default)
        end
      end

      context 'when given an exception' do
        it 'should raise that exception' do
          exception_to_raise = Exception.new('key not found')
          expect {
            subject.header 'not-found-key', exception_to_raise
          }.to raise_error(exception_to_raise.class)
        end
      end
    end
  end
end
