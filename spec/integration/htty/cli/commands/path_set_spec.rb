require 'htty/cli/commands/path_set'
require 'htty/session'

RSpec.describe HTTY::CLI::Commands::PathSet do
  subject(:command) { command_class.new session: session, arguments: arguments }

  let(:command_class) { described_class }

  let(:session) { HTTY::Session.new nil }

  let(:arguments) { [] }

  describe '#perform' do
    subject(:perform) { -> { command.perform } }

    describe 'without an argument' do
      specify { is_expected.to raise_error(ArgumentError) }
    end

    describe 'with an argument' do
      let(:arguments) { ['foo'] }

      it 'sets the path of the request' do
        perform[]
        expect(session.requests.last.uri.path).to eq("/#{arguments.first}")
      end

      describe "when there is a non-Basic 'Authorization' request header" do
        before :each do
          session.requests.last.header_set(*header)
          expect(session.requests.last.headers).to include(header)
        end

        let(:arguments) { ['bar'] }

        let(:header) { %w(Authorization foo) }

        it 'does not affect the header' do
          perform[]
          expect(session.requests.last.headers).to include(header)
        end
      end
    end
  end
end
