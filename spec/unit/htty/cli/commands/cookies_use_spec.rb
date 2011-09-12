require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies_add")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies_remove")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies_remove_all")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies_use")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_response")

describe HTTY::CLI::Commands::CookiesUse do
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
      klass.category.should == 'Building Requests'
    end

    it 'should have the expected command_line' do
      klass.command_line.should == 'cookies-u[se]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == nil
    end

    it 'should have the expected help' do
      klass.help.should == 'Uses cookies offered in the response'
    end

    it 'should have the expected help_extended' do
      klass.help_extended.should == 'Sets the cookies of the request to the ' +
                                    'cookies offered in the response (the '   +
                                    "'Set-Cookie' header). Does not "         +
                                    'communicate with the host.'
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::Cookies,
                                         HTTY::CLI::Commands::CookiesAdd,
                                         HTTY::CLI::Commands::CookiesRemove,
                                         HTTY::CLI::Commands::CookiesRemoveAll,
                                         HTTY::CLI::Commands::HeadersResponse]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('cookies-use', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == []
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('cookies-u', :session => :a_session)
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
