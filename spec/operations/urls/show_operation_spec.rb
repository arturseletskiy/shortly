# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Urls::ShowOperation, type: :operation do
  describe '.call' do
    let(:url) { create(:url) }

    subject do
      described_class.call(short_id: short_id)
    end

    context 'when url present' do
      let(:short_id) { url.short_id }

      it 'should return full url' do
        expect(subject.value!).to eq(url.full_url)
      end
    end

    context 'when url unknown' do
      let(:short_id) { '123' }

      it 'should return failure with message' do
        expect(subject.failure).to eq('url with short code 123 not found')
      end
    end
  end
end
