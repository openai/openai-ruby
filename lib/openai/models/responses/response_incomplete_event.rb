# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseIncompleteEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The response that was incomplete.
        #
        #   @return [OpenAI::Models::Responses::Response]
        required :response, -> { OpenAI::Models::Responses::Response }

        # @!attribute type
        #   The type of the event. Always `response.incomplete`.
        #
        #   @return [Symbol, :"response.incomplete"]
        required :type, const: :"response.incomplete"

        # @!method initialize(response:, type: :"response.incomplete")
        #   An event that is emitted when a response finishes as incomplete.
        #
        #   @param response [OpenAI::Models::Responses::Response]
        #   @param type [Symbol, :"response.incomplete"]
      end
    end
  end
end
