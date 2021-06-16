# frozen_string_literal: true

module Urls
  class ShowOperation < ApplicationOperation
    def execute(short_id:)
      id = Url.from_short_id(short_id)

      return not_found(short_id) unless id

      full_url = show_and_increment(id)

      if full_url.present?
        Success(full_url)
      else
        not_found(short_id)
      end
    end

    private

    def show_and_increment(id)
      result = Url.find_by_sql(
        <<-SQL
            UPDATE urls#{' '}
            SET views_count = views_count + 1
            WHERE id = #{id}
            RETURNING full_url;
        SQL
      )

      result[0]&.full_url
    end

    def not_found(short_id)
      Failure("url with short code #{short_id} not found")
    end
  end
end
