require 'htty/cli/commands/headers_request'
require 'htty/cli/commands/body_request'
require 'htty/cli/commands/cookies'
require 'htty/cli/commands/headers_response'
require 'htty/cli/commands/headers_set'
require 'htty/cli/commands/headers_unset'
require 'htty/cli/commands/headers_unset_all'

RSpec.describe HTTY::CLI::Commands::HeadersRequest do
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
      expect(klass.command_line).to eq('headers-req[uest]')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq(nil)
    end

    it 'should have the expected help' do
      expect(klass.help).to eq('Displays the headers of the request')
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Displays the headers used for the request. Does not communicate with the host.

Headers must have unique names. When you set a header that already exists, its value will be changed.

A 'Cookie' request header is marked with a bold asterisk (it looks like a cookie). Similarly, an 'Authorization' request header is marked with a bold mercantile symbol ('@').
      end_help_extended
      expect(klass.help_extended).to eq(expected.chomp)
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::HeadersSet,
                                             HTTY::CLI::Commands::HeadersUnset,
                                             HTTY::CLI::Commands::HeadersUnsetAll,
                                             HTTY::CLI::Commands::BodyRequest,
                                             HTTY::CLI::Commands::Cookies,
                                             HTTY::CLI::Commands::HeadersResponse])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('headers-request', session: :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq([])
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('headers-req', session: :a_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq([])
        expect(built.session).to eq(:a_session)
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x', session: :another_session)
        expect(built).to eq(nil)
      end
    end
  end
end
