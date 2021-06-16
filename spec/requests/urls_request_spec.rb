# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'urls', type: :request do
  describe 'POST /urls' do
    let(:full_url) { 'http://example.com/very_long' }
    it 'should create short url for passed full url' do
      post '/urls', params: full_url
      expect(response.body).to include("/urls/#{Url.first.short_id}")
      expect(response.status).to eq(201)
    end
  end

  describe 'GET /urls/:short_url' do
    context 'default' do
      let!(:url) { create(:url) }

      it 'should find full url through passed short url' do
        expect(url.views_count).to eq(0)
        get "/urls/#{url.short_id}"
        expect(response.body).to eq(url.full_url)
        expect(url.reload.views_count).to eq(1)
        expect(response.status).to eq(200)
      end
    end

    context 'when any error' do
      it 'should return views statistics for short url' do
        get '/urls/not_found'
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'GET /urls/:short_url/stats' do
    context 'default' do
      let!(:url) { create(:url, views_count: Random.rand(0..1000)) }

      it 'should return views statistics for short url' do
        get "/urls/#{url.short_id}/stats"
        expect(response.body).to eq(url.views_count.to_s)
        expect(response.status).to eq(200)
      end
    end

    context 'when any error' do
      it 'should return views statistics for short url' do
        get '/urls/not_found/stats'
        expect(response.status).to eq(422)
      end
    end
  end
end
