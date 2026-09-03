# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseSteerAcceptedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute sequence_number
        #   The sequence number for this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute steer
        #   The accepted steering submission.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseSteerAcceptedEvent::Steer]
        required :steer, -> { OpenAI::Beta::BetaResponseSteerAcceptedEvent::Steer }

        # @!attribute type
        #   The event discriminator. Always `response.steer.accepted`.
        #
        #   @return [Symbol, :"response.steer.accepted"]
        required :type, const: :"response.steer.accepted"

        # @!attribute stream_id
        #   The WebSocket lane that emitted this event. This field is present when the
        #   target response's `response.create` event supplied a `stream_id`.
        #
        #   @return [String, nil]
        optional :stream_id, String

        # @!method initialize(sequence_number:, steer:, stream_id: nil, type: :"response.steer.accepted")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseSteerAcceptedEvent} for more details.
        #
        #   Emitted when steering input has been validated and queued. Acceptance means the
        #   server owns the input, not that it has been applied. The successor's
        #   `response.created` event is the commit point. If accepted input cannot be
        #   committed, `response.steer.failed` returns it with the same steering ID.
        #
        #   When the response stops for client-owned tool output or approval, the input
        #   remains queued and `response.steer.pending` is emitted after
        #   `response.completed`. Fill the pending event's `required_input` stubs with saved
        #   results and send one matching explicit `response.create` per parent. Do not
        #   resend accepted input while it is still queued.
        #
        #   @param sequence_number [Integer] The sequence number for this event.
        #
        #   @param steer [OpenAI::Models::Beta::BetaResponseSteerAcceptedEvent::Steer] The accepted steering submission.
        #
        #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present when
        #
        #   @param type [Symbol, :"response.steer.accepted"] The event discriminator. Always `response.steer.accepted`.

        # @see OpenAI::Models::Beta::BetaResponseSteerAcceptedEvent#steer
        class Steer < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID assigned to the steering submission.
          #
          #   @return [String]
          required :id, String

          # @!attribute previous_response_id
          #   The ID of the response being steered.
          #
          #   @return [String]
          required :previous_response_id, String

          # @!method initialize(id:, previous_response_id:)
          #   The accepted steering submission.
          #
          #   @param id [String] The ID assigned to the steering submission.
          #
          #   @param previous_response_id [String] The ID of the response being steered.
        end
      end
    end

    BetaResponseSteerAcceptedEvent = Beta::BetaResponseSteerAcceptedEvent
  end
end
