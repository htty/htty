require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies_add")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies_remove")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies_remove_all")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/cookies_use")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_request")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/headers_response")

RSpec.describe HTTY::CLI::Commands::Cookies do
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
      expect(klass.category).to eq('Building Requests')
    end

    it 'should have the expected command_line' do
      expect(klass.command_line).to eq('cookies')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq(nil)
    end

    it 'should have the expected help' do
      expect(klass.help).to eq('Displays the cookies of the request')
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Displays the cookies used for the request. Does not communicate with the host.

This command displays cookies extracted from the request's 'Cookie' header, which is nevertheless shown when you type \e[1mheaders-req[uest]\e[0m.

Cookies are not required to have unique names. You can add multiple cookies with the same name, and they will be removed in last-in-first-out order.

Cookies are cleared automatically when you change hosts.
      end_help_extended
      expect(klass.help_extended).to eq(expected.chomp)
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::CookiesAdd,
                                             HTTY::CLI::Commands::CookiesRemove,
                                             HTTY::CLI::Commands::CookiesRemoveAll,
                                             HTTY::CLI::Commands::CookiesUse,
                                             HTTY::CLI::Commands::HeadersRequest,
                                             HTTY::CLI::Commands::HeadersResponse])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('cookies', :session => :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq([])
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a command line with a bad command' do
        built = klass.build_for('x', :session => :another_session)
        expect(built).to eq(nil)
      end
    end
  end
end
