require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookie_remove")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies_remove")

describe HTTY::CLI::Commands::CookieRemove do
  describe 'class' do
    let :klass do
      subject.class
    end

    it 'should be an alias_for the expected command' do
      klass.alias_for.should == HTTY::CLI::Commands::CookiesRemove
    end

    it 'should have the expected aliases' do
      klass.aliases.should == []
    end

    it 'should belong to the expected category' do
      klass.category.should == 'Building Requests'
    end

    it 'should have the expected command_line' do
      klass.command_line.should == 'cookie-r[emove]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == 'NAME'
    end

    it 'should have the expected help' do
      klass.help.should == "Alias for \e[1mcookies-remove\e[0m"
    end

    it 'should have the expected help_extended' do
      klass.help_extended.should == "Alias for \e[1mcookies-remove\e[0m."
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::CookiesRemove]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('cookie-remove foo', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == ['foo']
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('cookie-r bar', :session => :a_session)
        built.should be_instance_of(klass)
        built.arguments.should == ['bar']
        built.session.should   == :a_session
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x baz', :session => :another_session)
        built.should == nil
      end
    end
  end
end
