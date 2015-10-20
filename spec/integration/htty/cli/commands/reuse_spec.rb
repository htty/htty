require 'htty/cli/commands/reuse'

RSpec.describe HTTY::CLI::Commands::Reuse do

  let(:session) { HTTY::Session.new "http://google.com" }

  def instance(*arguments)
    described_class.new session: session, arguments: arguments
  end

  describe "#perform" do

    let(:request) { HTTY::Request.new("http://facebook.com") }

    before do
      session.requests << request
      session.requests.each { |request| allow(request).to receive(:response).and_return(true) }
    end

    it "shouldnt accumulate requests without response in session" do
      instance(1).perform
      instance(2).perform

      expect(session.requests.count).to eq(3)
      expect(session.requests.last.uri).to eq(request.uri)
    end
  end

end
