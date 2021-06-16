# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Urls::CreateOperation, type: :operation do
  describe '.call' do
    subject do
      described_class.call(full_url: full_url)
    end

    context 'when valid full url passed' do
      let(:full_url) { 'https://example.com/very_long_url' }

      it 'should return short url' do
        expect(subject.success).to be_present
        expect(Url.count).to eq(1)
      end
    end

    context 'when invalid full url passed' do
      let(:full_url) { 'just string' }

      it 'does not create link' do
        expect(subject.failure).to include('invalid')
      end
    end

    context 'when no full url passed' do
      let(:full_url) { nil }

      it 'does not create link' do
        expect(subject.failure).to include('blank')
      end
    end
  end
end
