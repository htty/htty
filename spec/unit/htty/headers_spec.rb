require File.expand_path("#{File.dirname __FILE__}/../../../lib/htty/headers")

RSpec.describe HTTY::Headers do
  describe 'that is empty' do
    it { should be_empty }

    describe 'when values are added out of order' do
      before :each do
        subject['foo'] = 'bar'
        subject['baz'] = 'qux'
      end

      it { should == {'foo' => 'bar', 'baz' => 'qux'} }

      it 'should return the expected array when sent #to_a' do
        expect(subject.to_a).to eq([%w(foo bar), %w(baz qux)])
      end
    end
  end

  describe 'that has values out of order' do
    subject { described_class.new('foo' => 'bar', 'baz' => 'qux') }

    it { should == {'foo' => 'bar', 'baz' => 'qux'} }

    it 'should index the values as expected' do
      expect(subject['foo']).to eq('bar')
      expect(subject['baz']).to eq('qux')
    end

    describe 'when sent #clear' do
      before :each do
        subject.clear
      end

      it { should be_empty }
    end
  end
end
