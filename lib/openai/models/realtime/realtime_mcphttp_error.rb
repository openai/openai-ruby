# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeMcphttpError < OpenAI::Internal::Type::BaseModel
        # @!attribute code
        #
        #   @return [Integer]
        required :code, Integer

        # @!attribute message
        #
        #   @return [String]
        required :message, String

        # @!attribute type
        #
        #   @return [Symbol, :http_error]
        required :type, const: :http_error

        # @!method initialize(code:, message:, type: :http_error)
        #   @param code [Integer]
        #   @param message [String]
        #   @param type [Symbol, :http_error]
      end
    end
  end
end
