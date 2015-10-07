require File.expand_path("#{File.dirname __FILE__}/../../../../lib/htty/request")
require File.expand_path("#{File.dirname __FILE__}/../../../../lib/htty/session")
require File.expand_path("#{File.dirname __FILE__}/../../../../lib/htty/cli/command")

RSpec.describe HTTY::CLI::Command do
  let(:last_request) {HTTY::Request.new('http://0.0.0.0')}
  let(:requests) {[last_request]}
  let(:session) do
    double(HTTY::Session).tap do |session|
      allow(session).to receive(:requests).and_return(requests)
    end
  end

  subject{described_class.new(session: session)}

  describe '#add_request_if_new' do
    context 'when command returns nil' do
      it 'should not add the request' do
        expect {
          subject.send :add_request_if_new do
            nil
          end
        }.not_to change{ subject.session.requests.count }
      end
    end

    context 'when command returns the same request' do
      it 'should not add the request' do
        expect {
          subject.send :add_request_if_new do
            last_request
          end
        }.not_to change { subject.session.requests.count }
      end
    end

    context 'when command returns a different request' do
      it 'should add the request' do
        expect {
          subject.send :add_request_if_new do
            HTTY::Request.new 'http://0.0.0.0/foo'
          end
        }.to change { subject.session.requests.count }.by(1)
      end
    end
  end
end
