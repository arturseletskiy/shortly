require 'dry/monads/do'
require 'dry/monads/result'
require 'dry/matcher/result_matcher'

class ApplicationOperation
  include Dry::Monads[:result, :do]

  class << self
    def call(args = {}, &block)
      result =
        begin
          new.execute(args)
        rescue StandardError => e
          raise e unless Rails.env.production?

          Dry::Monads::Failure('internal server error')
        end

      if block_given?
        Dry::Matcher::ResultMatcher.call(result, &block)
      else
        result
      end
    end
  end

  attr_reader :args

  def execute
    raise NotImplementedError
  end
end
