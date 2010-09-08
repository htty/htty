require 'spec'
require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/ordered_hash")

describe HTTY::OrderedHash do
  describe 'that is empty' do
    let(:hash) { HTTY::OrderedHash.new }

    it 'should be empty' do
      hash.should be_empty
    end

    describe '-- when values are added out of order' do
      before :each do
        hash['foo'] = 'bar'
        hash['baz'] = 'qux'
      end

      it '-- should have the expected values' do
        hash.should == {'foo' => 'bar', 'baz' => 'qux'}
      end

      it '-- should return the expected array when sent #to_a' do
        hash.to_a.should == [%w(foo bar), %w(baz qux)]
      end
    end
  end

  describe 'that has values out of order' do
    let(:hash) { HTTY::OrderedHash.new('foo' => 'bar', 'baz' => 'qux') }

    it 'should have the expected values' do
      hash.should == {'foo' => 'bar', 'baz' => 'qux'}
    end

    it 'should index the values as expected' do
      hash['foo'].should == 'bar'
      hash['baz'].should == 'qux'
    end

    describe '-- when sent #clear' do
      before :each do
        hash.clear
      end

      it '-- should be empty' do
        hash.should be_empty
      end
    end
  end
end
