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

        # @!attribute sequence_number
        #   The sequence number for this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.created`.
        #
        #   @return [Symbol, :"response.created"]
        required :type, const: :"response.created"

        # @!method initialize(response:, sequence_number:, type: :"response.created")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseCreatedEvent} for more details.
        #
        #   An event that is emitted when a response is created.
        #
        #   @param response [OpenAI::Responses::Response] The response that was created.
        #
        #   @param sequence_number [Integer] The sequence number for this event.
        #
        #   @param type [Symbol, :"response.created"] The type of the event. Always `response.created`.
      end
    end
  end
end
