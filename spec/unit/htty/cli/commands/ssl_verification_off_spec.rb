require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/ssl_verification")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/ssl_verification_off")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/ssl_verification_on")

describe HTTY::CLI::Commands::SslVerificationOff do
  describe 'class' do
    let :klass do
      subject.class
    end

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
      klass.command_line.should == 'ssl-verification-of[f]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == nil
    end

    it 'should have the expected help' do
      klass.help.should == 'Disables SSL certificate verification'
    end

    it 'should have the expected help_extended' do
      klass.help_extended.should == 'Disables SSL certificate verification. ' +
                                    'Does not communicate with the host.'
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::SslVerificationOn,
                                         HTTY::CLI::Commands::SslVerification]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('ssl-verification-off', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == []
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('ssl-verification-of', :session => :a_session)
        built.should be_instance_of(klass)
        built.arguments.should == []
        built.session.should   == :a_session
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x', :session => :another_session)
        built.should == nil
      end
    end
  end
end
