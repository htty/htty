require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/history")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/history_verbose")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/reuse")

RSpec.describe HTTY::CLI::Commands::Reuse do
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
      expect(klass.command_line).to eq('r[euse]')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq('INDEX')
    end

    it 'should have the expected help' do
      expect(klass.help).to eq('Copies a previous request by the index number ' +
                               'shown in history')
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Copies the properties of a previous request to be used for the request, using the request index number shown in history. Does not communicate with the host.

The argument is an index number that appears when you type \e[1mhistory\e[0m.
      end_help_extended
      expect(klass.help_extended).to eq(expected.chomp)
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::History,
                                             HTTY::CLI::Commands::HistoryVerbose])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('reuse foo', :session => :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq(['foo'])
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('r bar', :session => :a_session)
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
