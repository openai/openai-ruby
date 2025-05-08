# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCreatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The response that was created.
        #
        #   @return [OpenAI::Responses::Response]
        required :response, -> { OpenAI::Responses::Response }

        # @!attribute type
        #   The type of the event. Always `response.created`.
        #
        #   @return [Symbol, :"response.created"]
        required :type, const: :"response.created"

        # @!method initialize(response:, type: :"response.created")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseCreatedEvent} for more details.
        #
        #   An event that is emitted when a response is created.
        #
        #   @param response [OpenAI::Responses::Response] The response that was created.
        #
        #   @param type [Symbol, :"response.created"] The type of the event. Always `response.created`.
      end
    end
  end
end
