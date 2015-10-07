require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/body_response")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies_use")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_request")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_response")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/status")

RSpec.describe HTTY::CLI::Commands::HeadersResponse do
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
      expect(klass.category).to eq('Inspecting Responses')
    end

    it 'should have the expected command_line' do
      expect(klass.command_line).to eq('headers[-response]')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq(nil)
    end

    it 'should have the expected help' do
      expect(klass.help).to eq('Displays the headers of the response')
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Displays the headers received in the response. Does not communicate with the host.

A 'Set-Cookie' request header is marked with a bold asterisk (it looks like a cookie).
      end_help_extended
      expect(klass.help_extended).to eq(expected.chomp)
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::BodyResponse,
                                             HTTY::CLI::Commands::Cookies,
                                             HTTY::CLI::Commands::CookiesUse,
                                             HTTY::CLI::Commands::Status,
                                             HTTY::CLI::Commands::HeadersRequest])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('headers-response', :session => :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq([])
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('headers', :session => :a_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq([])
        expect(built.session).to eq(:a_session)
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x', :session => :another_session)
        expect(built).to eq(nil)
      end
    end
  end
end
