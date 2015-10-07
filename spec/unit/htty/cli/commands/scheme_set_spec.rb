require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/port_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/scheme_set")

RSpec.describe HTTY::CLI::Commands::SchemeSet do
  describe 'class' do
    let :klass do
      subject.class
    end

    it 'should be an alias_for the expected command' do
      expect(klass.alias_for).to eq(nil)
    end

    it 'should have the expected aliases' do
      expect(klass.aliases).to eq([])
    end

    it 'should belong to the expected category' do
      expect(klass.category).to eq('Navigation')
    end

    it 'should have the expected command_line' do
      expect(klass.command_line).to eq('sc[heme-set]')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq('SCHEME')
    end

    it 'should have the expected help' do
      expect(klass.help).to eq('Changes the scheme (protocol identifier) of ' +
                               "the request's address")
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Changes the scheme, or protocol identifier, used for the request. Does not communicate with the host.

The scheme you supply must be either 'http' or 'https'. Changing the scheme has no effect on the port, and vice versa.

The console prompt shows the address for the current request.
      end_help_extended
      expect(klass.help_extended).to eq(expected.chomp)
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::Address,
                                             HTTY::CLI::Commands::PortSet])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('scheme-set foo', :session => :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq(['foo'])
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('sc bar', :session => :a_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq(['bar'])
        expect(built.session).to eq(:a_session)
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x baz', :session => :another_session)
        expect(built).to eq(nil)
      end
    end
  end
end
