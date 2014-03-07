require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../../lib/htty/headers")
require File.expand_path("#{File.dirname __FILE__}/../../../../lib/htty/cli/display")

RSpec::Matchers.define :print_on_stdout do |check|

  @captured = nil

  match do |block|
    begin
      stdout_saved = $stdout
      $stdout = StringIO.new
      block.call
    ensure
      @captured = $stdout
      $stdout = stdout_saved
    end
    case check
    when String
      @captured.string == check
    when Regexp
      @captured.string.match(check)
    else
      false
    end
  end

  failure_message_for_should do
    "expected #{description}"
  end

  failure_message_for_should_not do
    "expected not #{description}"
  end

  description do
    "\n#{check}\non STDOUT but got\n#{@captured.string}\n"
  end
end

describe HTTY::CLI::Display do
  let(:display) {Class.new.new.extend(HTTY::CLI::Display)}

  describe '#show_headers' do
    it 'displays headers keeping the text case' do
      headers = HTTY::Headers.new('user-agent' => 'htty/1.4.1').to_a

      expect {display.show_headers(headers)}.to print_on_stdout(
        "user-agent:#{display.strong('')} htty/1.4.1\n"
      )
    end

    context 'with one header' do
      let(:headers) {HTTY::Headers.new('User-Agent' => 'htty/1.4.1').to_a}

      it 'displays the header starting from the beginning of the line' do
        expect {display.show_headers(headers)}.to print_on_stdout(
          "User-Agent:#{display.strong('')} htty/1.4.1\n"
        )
      end
    end

    context 'with few headers' do
      let(:headers) {
        headers = HTTY::Headers.new
        headers['User-Agent'] = 'htty/1.4.1'
        headers['Content-Type'] = 'application/json'
        headers.to_a
      }

      it 'aligns headers on colons' do
        expect {display.show_headers(headers)}.to print_on_stdout(
          "  User-Agent:#{display.strong('')} htty/1.4.1\n" +
          "Content-Type:#{display.strong('')} application/json\n"
        )
      end
    end

    context 'with marked headers' do
      context 'with one header' do
        let(:headers) {HTTY::Headers.new('User-Agent' => 'htty/1.4.1').to_a}
        let(:options) {{:show_mercantile_next_to => 'User-Agent'}}

        it 'displays the header starting from the beginning of the line' do
          expect {display.show_headers(headers, options)}.to print_on_stdout(
            "User-Agent:#{display.strong('@')} htty/1.4.1\n"
          )
        end
      end

      context 'with few headers' do
        let(:options) {{:show_mercantile_next_to => 'Content-Type'}}
        let(:headers) {
          headers = HTTY::Headers.new
          headers['User-Agent'] = 'htty/1.4.1'
          headers['Content-Type'] = 'application/json'
          headers.to_a
        }

        it 'aligns colons and mercantiles' do
          expect {display.show_headers(headers, options)}.to print_on_stdout(
            "   User-Agent:#{display.strong('')} htty/1.4.1\n" +
            "Content-Type:#{display.strong('@')} application/json\n"
          )
        end
      end
    end

    context 'when asked to mark an header' do
      let(:options) {{:show_mercantile_next_to => 'Content-Type'}}
      let(:headers) {HTTY::Headers.new('content-type' => 'application/json').to_a}

      it 'marks headers indipendently of the text case' do
        expect {display.show_headers(headers, options)}.to print_on_stdout(
          "content-type:#{display.strong('@')} application/json\n"
        )
      end
    end
  end
end
