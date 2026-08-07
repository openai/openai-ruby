# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferCommitEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The event type, must be `input_audio_buffer.commit`.
        #
        #   @return [Symbol, :"input_audio_buffer.commit"]
        required :type, const: :"input_audio_buffer.commit"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!method initialize(event_id: nil, type: :"input_audio_buffer.commit")
        #   Send this event to commit the user input audio buffer, which will create a new
        #   user message item in the conversation. This event will produce an error if the
        #   input audio buffer is empty. When in Server VAD mode, the client does not need
        #   to send this event, the server will commit the audio buffer automatically.
        #
        #   Committing the input audio buffer will trigger input audio transcription (if
        #   enabled in session configuration), but it will not create a response from the
        #   model. The server will respond with an `input_audio_buffer.committed` event.
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param type [Symbol, :"input_audio_buffer.commit"] The event type, must be `input_audio_buffer.commit`.
      end
    end
  end
end
