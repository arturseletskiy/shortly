# frozen_string_literal: true

module Urls
  class StatsOperation < ApplicationOperation
    def execute(short_id:)
      id = Url.from_short_id(short_id)
      return not_found(short_id) unless id
       
      url = Url.find(id)
      Success(url.views_count.to_s)
    rescue ActiveRecord::RecordNotFound => e
      not_found(short_id)
    end

    private

    def not_found(short_id)
      Failure("url with short code #{short_id} not found")
    end
  end
end
