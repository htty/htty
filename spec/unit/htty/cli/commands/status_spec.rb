require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/body_response")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_response")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/status")

RSpec.describe HTTY::CLI::Commands::Status do
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
      expect(klass.command_line).to eq('st[atus]')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq(nil)
    end

    it 'should have the expected help' do
      expect(klass.help).to eq('Displays the status of the response')
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Displays the status signal, the number of headers, and size of the body received in the response. Does not communicate with the host.

If a 'Set-Cookie' request header is present, a bold asterisk (it looks like a cookie) appears next to the headers summary.

Status is displayed automatically when a response is received.
      end_help_extended
      expect(klass.help_extended).to eq(expected.chomp)
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::BodyResponse,
                                             HTTY::CLI::Commands::HeadersResponse])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('status', :session => :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq([])
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('st', :session => :a_session)
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
