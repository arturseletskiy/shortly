# frozen_string_literal: true

class UrlsController < ApplicationController
  def create
    Urls::CreateOperation.call(full_url: request.raw_post) do |result|
      result.success do |value|
        render plain: value, status: :created
      end

      result.failure do |errors|
        render plain: errors, status: :unprocessable_entity
      end
    end
  end

  def show
    Urls::ShowOperation.call(short_id: params[:id]) do |result|
      result.success do |value|
        render plain: value, status: :ok
      end

      result.failure do |errors|
        render plain: errors, status: :unprocessable_entity
      end
    end
  end

  def stats
    Urls::StatsOperation.call(short_id: params[:id]) do |result|
      result.success do |value|
        render plain: value, status: :ok
      end

      result.failure do |errors|
        render plain: errors, status: :unprocessable_entity
      end
    end
  end
end
