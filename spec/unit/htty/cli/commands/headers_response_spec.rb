require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/body_response")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies_use")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_request")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_response")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/status")

describe HTTY::CLI::Commands::HeadersResponse do
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
      klass.category.should == 'Inspecting Responses'
    end

    it 'should have the expected command_line' do
      klass.command_line.should == 'headers[-response]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == nil
    end

    it 'should have the expected help' do
      klass.help.should == 'Displays the headers of the response'
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Displays the headers received in the response. Does not communicate with the host.

A 'Set-Cookie' request header is marked with a bold asterisk (it looks like a cookie).
      end_help_extended
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::BodyResponse,
                                         HTTY::CLI::Commands::Cookies,
                                         HTTY::CLI::Commands::CookiesUse,
                                         HTTY::CLI::Commands::Status,
                                         HTTY::CLI::Commands::HeadersRequest]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('headers-response', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == []
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('headers', :session => :a_session)
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
