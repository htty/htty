require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/port_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/scheme_set")

describe HTTY::CLI::Commands::SchemeSet do
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
      klass.command_line.should == 'sc[heme-set]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == 'SCHEME'
    end

    it 'should have the expected help' do
      klass.help.should == 'Changes the scheme (protocol identifier) of the ' +
                           "request's address"
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Changes the scheme, or protocol identifier, used for the request. Does not communicate with the host.

The scheme you supply must be either 'http' or 'https'. Changing the scheme has no effect on the port, and vice versa.

The console prompt shows the address for the current request.
      end_help_extended
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::Address,
                                         HTTY::CLI::Commands::PortSet]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('scheme-set foo', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == ['foo']
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('sc bar', :session => :a_session)
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
