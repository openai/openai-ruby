# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseIncompleteEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The response that was incomplete.
        #
        #   @return [OpenAI::Models::Responses::Response]
        required :response, -> { OpenAI::Responses::Response }

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.incomplete`.
        #
        #   @return [Symbol, :"response.incomplete"]
        required :type, const: :"response.incomplete"

        # @!method initialize(response:, sequence_number:, type: :"response.incomplete")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseIncompleteEvent} for more details.
        #
        #   An event that is emitted when a response finishes as incomplete.
        #
        #   @param response [OpenAI::Models::Responses::Response] The response that was incomplete.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.incomplete"] The type of the event. Always `response.incomplete`.
      end
    end
  end
end
