# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferClearedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute type
        #   The event type, must be `input_audio_buffer.cleared`.
        #
        #   @return [Symbol, :"input_audio_buffer.cleared"]
        required :type, const: :"input_audio_buffer.cleared"

        # @!method initialize(event_id:, type: :"input_audio_buffer.cleared")
        #   Returned when the input audio buffer is cleared by the client with a
        #   `input_audio_buffer.clear` event.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param type [Symbol, :"input_audio_buffer.cleared"] The event type, must be `input_audio_buffer.cleared`.
      end
    end
  end
end
