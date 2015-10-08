require 'htty/cli/commands/body_request'
require 'htty/cli/commands/headers_request'
require 'htty/cli/commands/body_request_open'
require 'htty/cli/commands/body_response'
require 'htty/cli/commands/body_set'
require 'htty/cli/commands/body_unset'

RSpec.describe HTTY::CLI::Commands::BodyRequest do
  describe 'class' do
    let :klass do
      subject.class
    end

    it 'should be an alias_for the expected command' do
      expect(klass.alias_for).to eq(nil)
    end

    it 'should have the expected aliases' do
      expect(klass.aliases).to eq([])
    end

    it 'should belong to the expected category' do
      expect(klass.category).to eq('Building Requests')
    end

    it 'should have the expected command_line' do
      expect(klass.command_line).to eq('body-request')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq(nil)
    end

    it 'should have the expected help' do
      expect(klass.help).to eq('Displays the body of the request')
    end

    it 'should have the expected help_extended' do
      expect(klass.help_extended).to eq('Displays the body content used for the ' +
                                        'request. Does not communicate with the ' +
                                        'host.')
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::BodyRequestOpen,
                                             HTTY::CLI::Commands::BodySet,
                                             HTTY::CLI::Commands::BodyUnset,
                                             HTTY::CLI::Commands::HeadersRequest,
                                             HTTY::CLI::Commands::BodyResponse])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('body-request', :session => :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq([])
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x', :session => :another_session)
        expect(built).to eq(nil)
      end
    end
  end
end
