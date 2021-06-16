# frozen_string_literal: true

module Urls
  class CreateOperation < ApplicationOperation
    def execute(full_url:)
      url = Url.create!(full_url: full_url)
      Success(Rails.application.routes.url_helpers.url_url(id: url.short_id))
    rescue ActiveRecord::RecordInvalid => e
      Failure(e.message)
    end
  end
end
