# frozen_string_literal: true

FactoryBot.define do
  factory :url do
    full_url { "http://example.com/very_long/#{Random.rand(1_000_000..9_999_999)}" }
  end
end
