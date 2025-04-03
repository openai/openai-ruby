# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseFailedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The response that failed.
        #
        #   @return [OpenAI::Models::Responses::Response]
        required :response, -> { OpenAI::Models::Responses::Response }

        # @!attribute type
        #   The type of the event. Always `response.failed`.
        #
        #   @return [Symbol, :"response.failed"]
        required :type, const: :"response.failed"

        # @!parse
        #   # An event that is emitted when a response fails.
        #   #
        #   # @param response [OpenAI::Models::Responses::Response]
        #   # @param type [Symbol, :"response.failed"]
        #   #
        #   def initialize(response:, type: :"response.failed", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
