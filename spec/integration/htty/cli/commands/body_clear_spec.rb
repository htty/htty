require 'rspec'
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/session")
require File.expand_path("#{File.dirname __FILE__}/../../../../../lib/htty/cli/commands/body_clear")

describe HTTY::CLI::Commands::BodyClear do
  let :klass do
    subject.class
  end

  let :session do
    HTTY::Session.new nil
  end

  let :instance do
    klass.new :session => session
  end

  it_should_behave_like "the 'body-unset' command"
end
