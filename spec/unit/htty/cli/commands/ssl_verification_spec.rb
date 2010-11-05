require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/ssl_verification")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/ssl_verification_off")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/ssl_verification_on")

describe HTTY::CLI::Commands::SslVerification do
  let :klass do
    subject.class
  end

  let :session do
    HTTY::Session.new nil
  end

  describe 'class' do
    it 'should be an alias_for the expected command' do
      klass.alias_for.should == nil
    end

    it 'should have the expected aliases' do
      klass.aliases.should == []
    end

    it 'should belong to the expected category' do
      klass.category.should == 'Preferences'
    end

    it 'should have the expected command_line' do
      klass.command_line.should == 'ssl-verification'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == nil
    end

    it 'should have the expected help' do
      klass.help.should == 'Displays the preference for SSL certificate ' +
                           'verification'
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Displays the preference for SSL certificate verification. Does not communicate with the host.

When issuing HTTP Secure requests, server certificates will be verified. You can disable and reenable this behavior.
      end_help_extended
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::SslVerificationOff,
                                         HTTY::CLI::Commands::SslVerificationOn]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('ssl-verification', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == []
        built.session.should   == :the_session
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x', :session => :another_session)
        built.should == nil
      end
    end
  end
end
