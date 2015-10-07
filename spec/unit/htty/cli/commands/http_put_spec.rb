require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/http_delete")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/http_get")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/http_patch")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/http_post")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/http_put")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/put")

RSpec.describe HTTY::CLI::Commands::HttpPut do
  describe 'class' do
    let :klass do
      subject.class
    end

    it 'should be an alias_for the expected command' do
      expect(klass.alias_for).to eq(nil)
    end

    it 'should have the expected aliases' do
      expect(klass.aliases).to eq([HTTY::CLI::Commands::Put])
    end

    it 'should belong to the expected category' do
      expect(klass.category).to eq('Issuing Requests')
    end

    it 'should have the expected command_line' do
      expect(klass.command_line).to eq('http-pu[t]')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq(nil)
    end

    it 'should have the expected help' do
      expect(klass.help).to eq('Issues an HTTP PUT using the current request')
    end

    it 'should have the expected help_extended' do
      expect(klass.help_extended).to eq('Issues an HTTP PUT using the current ' +
                                        'request.')
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::HttpGet,
                                             HTTY::CLI::Commands::HttpPatch,
                                             HTTY::CLI::Commands::HttpPost,
                                             HTTY::CLI::Commands::HttpDelete])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('http-put', :session => :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq([])
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('http-pu', :session => :a_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq([])
        expect(built.session).to eq(:a_session)
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x', :session => :another_session)
        expect(built).to eq(nil)
      end
    end
  end
end
