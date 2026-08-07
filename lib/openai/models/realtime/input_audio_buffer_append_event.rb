# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferAppendEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute audio
        #   Base64-encoded audio bytes. This must be in the format specified by the
        #   `input_audio_format` field in the session configuration.
        #
        #   @return [String]
        required :audio, String

        # @!attribute type
        #   The event type, must be `input_audio_buffer.append`.
        #
        #   @return [Symbol, :"input_audio_buffer.append"]
        required :type, const: :"input_audio_buffer.append"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!method initialize(audio:, event_id: nil, type: :"input_audio_buffer.append")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::InputAudioBufferAppendEvent} for more details.
        #
        #   Send this event to append audio bytes to the input audio buffer. The audio
        #   buffer is temporary storage you can write to and later commit. A "commit" will
        #   create a new user message item in the conversation history from the buffer
        #   content and clear the buffer. Input audio transcription (if enabled) will be
        #   generated when the buffer is committed.
        #
        #   If VAD is enabled the audio buffer is used to detect speech and the server will
        #   decide when to commit. When Server VAD is disabled, you must commit the audio
        #   buffer manually. Input audio noise reduction operates on writes to the audio
        #   buffer.
        #
        #   The client may choose how much audio to place in each event up to a maximum of
        #   15 MiB, for example streaming smaller chunks from the client may allow the VAD
        #   to be more responsive. Unlike most other client events, the server will not send
        #   a confirmation response to this event.
        #
        #   @param audio [String] Base64-encoded audio bytes. This must be in the format specified by the
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param type [Symbol, :"input_audio_buffer.append"] The event type, must be `input_audio_buffer.append`.
      end
    end
  end
end
