require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/userinfo_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/userinfo_unset")

describe HTTY::CLI::Commands::UserinfoSet do
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
      klass.category.should == 'Navigation'
    end

    it 'should have the expected command_line' do
      klass.command_line.should == 'userinfo-s[et]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == 'USERNAME [PASSWORD]'
    end

    it 'should have the expected help' do
      klass.help.should == "Sets the userinfo of the request's address"
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Sets the userinfo used for the request. Does not communicate with the host.

Userinfo will be URL-encoded if necessary.

When userinfo is set, a corresponding 'Authorization' header is set automatically.

The console prompt shows the address for the current request. Userinfo appears in normal type while the rest of the address appears in bold to indicate that userinfo is sent to the host in the form of a header.
      end_help_extended
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::UserinfoUnset,
                                         HTTY::CLI::Commands::Address]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('userinfo-set foo bar', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == %w(foo bar)
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('userinfo-s baz', :session => :a_session)
        built.should be_instance_of(klass)
        built.arguments.should == ['baz']
        built.session.should   == :a_session
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x qux', :session => :another_session)
        built.should == nil
      end
    end

    describe '#sanitize_arguments' do
      context 'when only one argument like username:password' do
        let(:arguments) {['username:password']}

        it 'should be splitted in two arguments' do
          klass.sanitize_arguments(arguments).should == [
            'username', 'password'
          ]
        end
      end

      context 'when arguments contains special characters' do
        let(:arguments) {['user/name', 'password']}

        it 'should escape them' do
          klass.sanitize_arguments(arguments).should == [
            'user%2Fname', 'password'
          ]
        end
      end
    end
  end
end
