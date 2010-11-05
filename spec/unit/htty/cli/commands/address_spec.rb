require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/address")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/fragment_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/host_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/path_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/port_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/query_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/scheme_set")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/userinfo_set")

describe HTTY::CLI::Commands::Address do
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
      klass.command_line.should == 'a[ddress]'
    end

    it 'should have the expected command_line_arguments' do
      klass.command_line_arguments.should == 'ADDRESS'
    end

    it 'should have the expected help' do
      klass.help.should == 'Changes the address of the request'
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
      klass.help_extended.should == expected.chomp
    end

    it 'should have the expected see_also_commands' do
      klass.see_also_commands.should == [HTTY::CLI::Commands::SchemeSet,
                                         HTTY::CLI::Commands::UserinfoSet,
                                         HTTY::CLI::Commands::HostSet,
                                         HTTY::CLI::Commands::PortSet,
                                         HTTY::CLI::Commands::PathSet,
                                         HTTY::CLI::Commands::QuerySet,
                                         HTTY::CLI::Commands::FragmentSet]
    end

    describe 'build_for' do
      it 'should correctly handle a valid, unabbreviated command line' do
        built = klass.build_for('address foo', :session => :the_session)
        built.should be_instance_of(klass)
        built.arguments.should == ['foo']
        built.session.should   == :the_session
      end

      it 'should correctly handle a valid, abbreviated command line' do
        built = klass.build_for('a bar', :session => :a_session)
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
