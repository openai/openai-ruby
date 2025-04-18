# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCreatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The response that was created.
        #
        #   @return [OpenAI::Models::Responses::Response]
        required :response, -> { OpenAI::Models::Responses::Response }

        # @!attribute type
        #   The type of the event. Always `response.created`.
        #
        #   @return [Symbol, :"response.created"]
        required :type, const: :"response.created"

        # @!method initialize(response:, type: :"response.created")
        #   An event that is emitted when a response is created.
        #
        #   @param response [OpenAI::Models::Responses::Response]
        #   @param type [Symbol, :"response.created"]
      end
    end
  end
end
