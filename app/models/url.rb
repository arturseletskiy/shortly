require 'uri'

class Url < ApplicationRecord
  class << self
    def find_by_short_id!(short_id)
      Url.find(from_short_id(short_id))
    end

    def from_short_id(value)
      Base64.urlsafe_decode64(value)
    rescue ArgumentError => e
      nil
    end

    def to_short_id(value)
      Base64.urlsafe_encode64(value.to_s, padding: false) if value.present?
    end
  end

  validates :full_url, presence: true
  validate :full_url_format_validation, if: :full_url?

  def short_id
    self.class.to_short_id(id ||
        raise(ArgumentError, 'short_id for only persisted in database urls!'))
  end

  private

  def full_url_format_validation
    uri = URI.parse(full_url)

    errors.add(:full_url, :invalid) if !uri.is_a?(URI::HTTP) || uri.host.nil?
  rescue URI::InvalidURIError
    errors.add(:full_url, :invalid)
  end
end
