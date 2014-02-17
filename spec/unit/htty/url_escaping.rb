require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/cli/url_escaping")

describe HTTY::CLI::UrlEscaping do
  subject do
    o = Object.new.extend(HTTY::CLI::UrlEscaping)
    o.stub(:say)
    o
  end

  describe '.escape_or_warn_of_escape_sequences' do
    context 'when argument is already escaped' do
      let(:escaped_string) {'Hello%20World'}

      it 'should not escape it twice' do
        should_not_escape(escaped_string)
      end

      it 'should warn the user' do
        subject.should_receive(:say).once
        escape(escaped_string)
      end
    end

    context 'when argument contains reserved characters' do
      let(:unescaped_string) {'Hello World'}

      it 'should escape it' do
        should_escape(unescaped_string)
      end

      it 'should not warn the user' do
        subject.should_receive(:say).never
        escape(unescaped_string)
      end
    end

    context 'when argument contains not reserved characters' do
      let(:unescaped_string) {'HelloWorld'}

      it 'should not escape it' do
        should_not_escape(unescaped_string)
      end

      it 'should not warn the user' do
        subject.should_receive(:say).never
        escape(unescaped_string)
      end
    end

    # http://tools.ietf.org/html/rfc3986#section-2.2
    ":/?#[]@!$&'()*+,;=".each_char do |reserved_character|
      it "should escape reserved character '#{reserved_character}'" do
        should_escape(reserved_character)
      end
    end
  end

  def should_escape(s)
    escape(s).should_not == [s]
  end

  def should_not_escape(s)
    escape(s).should == [s]
  end

  def escape(s)
    subject.escape_or_warn_of_escape_sequences([s])
  end
end
