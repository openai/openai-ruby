# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class OutputAudioBufferClearEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The event type, must be `output_audio_buffer.clear`.
        #
        #   @return [Symbol, :"output_audio_buffer.clear"]
        required :type, const: :"output_audio_buffer.clear"

        # @!attribute event_id
        #   The unique ID of the client event used for error handling.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!method initialize(event_id: nil, type: :"output_audio_buffer.clear")
        #   **WebRTC/SIP Only:** Emit to cut off the current audio response. This will
        #   trigger the server to stop generating audio and emit a
        #   `output_audio_buffer.cleared` event. This event should be preceded by a
        #   `response.cancel` client event to stop the generation of the current response.
        #   [Learn more](https://platform.openai.com/docs/guides/realtime-conversations#client-and-server-events-for-audio-in-webrtc).
        #
        #   @param event_id [String] The unique ID of the client event used for error handling.
        #
        #   @param type [Symbol, :"output_audio_buffer.clear"] The event type, must be `output_audio_buffer.clear`.
      end
    end
  end
end
