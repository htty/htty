require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/fragment_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/host_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/path_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/port_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/scheme_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/userinfo_set")

RSpec.describe HTTY::CLI::Commands::Address do
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
      expect(klass.command_line).to eq('a[ddress]')
    end

    it 'should have the expected command_line_arguments' do
      expect(klass.command_line_arguments).to eq('ADDRESS')
    end

    it 'should have the expected help' do
      expect(klass.help).to eq('Changes the address of the request')
    end

    it 'should have the expected help_extended' do
      expected = <<-end_help_extended
Changes the address used for the request. Does not communicate with the host.

The URL you supply can be partial. At a minimum, you must specify a host. The optional and required elements of an address are illustrated below:

https://steve:woodside@apple.com:6666/store?q=ipad#sold-to-date
\\______/\\_____________/\\_______/\\___/\\____/\\_____/\\___________/
   1.          2.          3.     4.   5.     6.        7.

1. A scheme, or protocol identifier (i.e., 'http://' or 'https://' -- optional)
2. Userinfo (e.g., 'username:password@' -- optional)
3. A host (i.e., a hostname or IP address -- required)
4. A TCP port number (i.e., ':0' through ':65535' -- optional)
5. A path (optional)
6. A query string (e.g., '?foo=bar&baz=qux' -- optional)
7. A fragment (e.g., '#fragment-name' -- optional)

If (1) is omitted, HTTP is used, except if (4) is specified as port 443, in which case HTTPS is used.

If (3) is omitted, host 0.0.0.0 is used.

If (4) is omitted, port 80 is used, except if (1) is specified as HTTPS, in which case port 443 is used.

If (5) is omitted, the root path (i.e., '/') is used.

The console prompt shows the address for the current request.
      end_help_extended
      expect(klass.help_extended).to eq(expected.chomp)
    end

    it 'should have the expected see_also_commands' do
      expect(klass.see_also_commands).to eq([HTTY::CLI::Commands::SchemeSet,
                                             HTTY::CLI::Commands::UserinfoSet,
                                             HTTY::CLI::Commands::HostSet,
                                             HTTY::CLI::Commands::PortSet,
                                             HTTY::CLI::Commands::PathSet,
                                             HTTY::CLI::Commands::QuerySet,
                                             HTTY::CLI::Commands::FragmentSet])
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('address foo', :session => :the_session)
        expect(built).to be_instance_of(klass)
        expect(built.arguments).to eq(['foo'])
        expect(built.session).to eq(:the_session)
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('a bar', :session => :a_session)
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
