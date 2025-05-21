# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseQueuedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response
        #   The full response object that is queued.
        #
        #   @return [OpenAI::Responses::Response]
        required :response, -> { OpenAI::Responses::Response }

        # @!attribute sequence_number
        #   The sequence number for this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.queued'.
        #
        #   @return [Symbol, :"response.queued"]
        required :type, const: :"response.queued"

        # @!method initialize(response:, sequence_number:, type: :"response.queued")
        #   Emitted when a response is queued and waiting to be processed.
        #
        #   @param response [OpenAI::Responses::Response] The full response object that is queued.
        #
        #   @param sequence_number [Integer] The sequence number for this event.
        #
        #   @param type [Symbol, :"response.queued"] The type of the event. Always 'response.queued'.
      end
    end
  end
end
