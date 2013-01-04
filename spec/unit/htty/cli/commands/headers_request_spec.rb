require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/body_request")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_request")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_response")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_unset")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_unset_all")

describe HTTY::CLI::Commands::HeadersRequest do
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
      klass.command_line.should == 'headers-req[uest]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == nil
    end

    it 'should have the expected help' do
      klass.help.should == 'Displays the headers of the request'
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Displays the headers used for the request. Does not communicate with the host.

Headers must have unique names. When you set a header that already exists, its value will be changed.

A 'Cookie' request header is marked with a bold asterisk (it looks like a cookie). Similarly, an 'Authorization' request header is marked with a bold mercantile symbol ('@').
      end_help_extended
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::HeadersSet,
                                         HTTY::CLI::Commands::HeadersUnset,
                                         HTTY::CLI::Commands::HeadersUnsetAll,
                                         HTTY::CLI::Commands::BodyRequest,
                                         HTTY::CLI::Commands::Cookies,
                                         HTTY::CLI::Commands::HeadersResponse]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('headers-request', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == []
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('headers-req', :session => :a_session)
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
