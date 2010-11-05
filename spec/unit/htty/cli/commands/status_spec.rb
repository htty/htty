require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/body_response")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_response")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/status")

describe HTTY::CLI::Commands::Status do
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
      klass.command_line.should == 'st[atus]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == nil
    end

    it 'should have the expected help' do
      klass.help.should == 'Displays the status of the response'
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Displays the status signal, the number of headers, and size of the body received in the response. Does not communicate with the host.

If a 'Set-Cookie' request header is present, a bold asterisk (it looks like a cookie) appears next to the headers summary.

Status is displayed automatically when a response is received.
      end_help_extended
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::BodyResponse,
                                         HTTY::CLI::Commands::HeadersResponse]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('status', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == []
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('st', :session => :a_session)
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
