# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCompletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   Properties of the completed response.
        #
        #   @return [OpenAI::Responses::Response]
        required :response, -> { OpenAI::Responses::Response }

        # @!attribute sequence_number
        #   The sequence number for this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.completed`.
        #
        #   @return [Symbol, :"response.completed"]
        required :type, const: :"response.completed"

        # @!method initialize(response:, sequence_number:, type: :"response.completed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseCompletedEvent} for more details.
        #
        #   Emitted when the model response is complete.
        #
        #   @param response [OpenAI::Responses::Response] Properties of the completed response.
        #
        #   @param sequence_number [Integer] The sequence number for this event.
        #
        #   @param type [Symbol, :"response.completed"] The type of the event. Always `response.completed`.
      end
    end
  end
end
