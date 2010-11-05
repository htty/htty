require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_clear")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_request")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_unset")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_unset_all")

describe HTTY::CLI::Commands::HeadersUnsetAll do
  describe 'class' do
    let :klass do
      subject.class
    end

    it 'should be an alias_for the expected command' do
      klass.alias_for.should == nil
    end

    it 'should have the expected aliases' do
      klass.aliases.should == [HTTY::CLI::Commands::HeadersClear]
    end

    it 'should belong to the expected category' do
      klass.category.should == 'Building Requests'
    end

    it 'should have the expected command_line' do
      klass.command_line.should == 'headers-unset-[all]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == nil
    end

    it 'should have the expected help' do
      klass.help.should == 'Removes all headers from the request'
    end

    it 'should have the expected help_extended' do
      klass.help_extended.should == 'Removes all headers used for the '       +
                                    'request. Does not communicate with the ' +
                                    'host.'
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::HeadersRequest,
                                         HTTY::CLI::Commands::HeadersUnset,
                                         HTTY::CLI::Commands::HeadersSet]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('headers-unset-all', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == []
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('headers-unset-', :session => :a_session)
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
