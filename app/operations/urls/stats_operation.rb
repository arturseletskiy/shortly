module Urls
  class StatsOperation < ApplicationOperation
    def execute(short_id:)
      url = Url.find_by_short_id!(short_id)
      Success(url.views_count.to_s)
    rescue ActiveRecord::RecordNotFound => e
      Failure("url with short code #{short_id} not found")
    end
  end
end
