require 'spec_helper'
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/headers")

describe HTTY::Headers do
  describe 'that is empty' do
    it { should be_empty }

    describe 'when values are added out of order' do
      before :each do
        subject['foo'] = 'bar'
        subject['baz'] = 'qux'
      end

      it { should == {'foo' => 'bar', 'baz' => 'qux'} }

      it 'should return the expected array when sent #to_a' do
        subject.to_a.should == [%w(foo bar), %w(baz qux)]
      end
    end
  end

  describe 'that has values out of order' do
    subject { described_class.new('foo' => 'bar', 'baz' => 'qux') }

    it { should == {'foo' => 'bar', 'baz' => 'qux'} }

    it 'should index the values as expected' do
      subject['foo'].should == 'bar'
      subject['baz'].should == 'qux'
    end

    describe 'when sent #clear' do
      before :each do
        subject.clear
      end

      it { should be_empty }
    end
  end
end
