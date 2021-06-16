require 'rails_helper'

RSpec.describe Url, type: :model do
  describe '.to_short_id' do
    context 'default' do
      it 'should convert id (integer) to short id (base 62)' do
        expect(described_class.to_short_id(123)).to eq('MTIz')
      end
    end

    context 'empty' do
      it 'does not converting' do
        expect(described_class.to_short_id(nil)).to eq(nil)
      end
    end
  end

  describe '.from_short_id' do
    it 'should convert short id (base 62) to id (integer)' do
      expect(described_class.from_short_id('MTIz')).to eq('123')
    end
  end
end
