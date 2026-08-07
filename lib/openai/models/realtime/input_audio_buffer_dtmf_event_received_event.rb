# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferDtmfEventReceivedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event
        #   The telephone keypad that was pressed by the user.
        #
        #   @return [String]
        required :event, String

        # @!attribute received_at
        #   UTC Unix Timestamp when DTMF Event was received by server.
        #
        #   @return [Integer]
        required :received_at, Integer

        # @!attribute type
        #   The event type, must be `input_audio_buffer.dtmf_event_received`.
        #
        #   @return [Symbol, :"input_audio_buffer.dtmf_event_received"]
        required :type, const: :"input_audio_buffer.dtmf_event_received"

        # @!method initialize(event:, received_at:, type: :"input_audio_buffer.dtmf_event_received")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::InputAudioBufferDtmfEventReceivedEvent} for more
        #   details.
        #
        #   **SIP Only:** Returned when an DTMF event is received. A DTMF event is a message
        #   that represents a telephone keypad press (0–9, \*, #, A–D). The `event` property
        #   is the keypad that the user press. The `received_at` is the UTC Unix Timestamp
        #   that the server received the event.
        #
        #   @param event [String] The telephone keypad that was pressed by the user.
        #
        #   @param received_at [Integer] UTC Unix Timestamp when DTMF Event was received by server.
        #
        #   @param type [Symbol, :"input_audio_buffer.dtmf_event_received"] The event type, must be `input_audio_buffer.dtmf_event_received`.
      end
    end
  end
end
