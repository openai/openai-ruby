# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferClearEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The event type, must be `input_audio_buffer.clear`.
        #
        #   @return [Symbol, :"input_audio_buffer.clear"]
        required :type, const: :"input_audio_buffer.clear"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!method initialize(event_id: nil, type: :"input_audio_buffer.clear")
        #   Send this event to clear the audio bytes in the buffer. The server will respond
        #   with an `input_audio_buffer.cleared` event.
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param type [Symbol, :"input_audio_buffer.clear"] The event type, must be `input_audio_buffer.clear`.
      end
    end
  end
end
