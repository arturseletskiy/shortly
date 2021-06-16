FactoryBot.define do
  factory :url do
    full_url { "http://example.com/very_long/#{Random.rand(1000000..9999999)}" }
  end
end