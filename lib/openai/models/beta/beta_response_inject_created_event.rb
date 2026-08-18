# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseInjectCreatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute response_id
        #   The ID of the response that accepted the input.
        #
        #   @return [String]
        required :response_id, String

        # @!attribute sequence_number
        #   The sequence number for this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The event discriminator. Always `response.inject.created`.
        #
        #   @return [Symbol, :"response.inject.created"]
        required :type, const: :"response.inject.created"

        # @!attribute stream_id
        #   The multiplexed WebSocket stream that emitted the event. This field is present
        #   only when WebSocket multiplexing is enabled separately.
        #
        #   @return [String, nil]
        optional :stream_id, String

        # @!method initialize(response_id:, sequence_number:, stream_id: nil, type: :"response.inject.created")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseInjectCreatedEvent} for more details.
        #
        #   Emitted when all injected input items were validated and committed to the active
        #   response.
        #
        #   @param response_id [String] The ID of the response that accepted the input.
        #
        #   @param sequence_number [Integer] The sequence number for this event.
        #
        #   @param stream_id [String] The multiplexed WebSocket stream that emitted the event. This field is
        #
        #   @param type [Symbol, :"response.inject.created"] The event discriminator. Always `response.inject.created`.
      end
    end

    BetaResponseInjectCreatedEvent = Beta::BetaResponseInjectCreatedEvent
  end
end
