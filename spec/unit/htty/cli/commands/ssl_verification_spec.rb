require 'htty/cli/commands/ssl_verification'
require 'htty/cli/commands/ssl_verification_off'
require 'htty/cli/commands/ssl_verification_on'

RSpec.describe HTTY::CLI::Commands::SslVerification do
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
      expect(klass.category).to eq('Preferences')
    end

    it 'should have the expected command_line' do
      expect(klass.command_line).to eq('ssl-verification')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq(nil)
    end

    it 'should have the expected help' do
      expect(klass.help).to eq('Displays the preference for SSL certificate ' +
                               'verification')
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Displays the preference for SSL certificate verification. Does not communicate with the host.

When issuing HTTP Secure requests, server certificates will be verified. You can disable and reenable this behavior.
      end_help_extended
      expect(klass.help_extended).to eq(expected.chomp)
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::SslVerificationOff,
                                             HTTY::CLI::Commands::SslVerificationOn])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('ssl-verification', :session => :the_session)
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
