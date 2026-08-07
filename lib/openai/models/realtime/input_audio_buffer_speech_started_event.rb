# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferSpeechStartedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute audio_start_ms
        #   Milliseconds from the start of all audio written to the buffer during the
        #   session when speech was first detected. This will correspond to the beginning of
        #   audio sent to the model, and thus includes the `prefix_padding_ms` configured in
        #   the Session.
        #
        #   @return [Integer]
        required :audio_start_ms, Integer

        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the user message item that will be created when speech stops.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute type
        #   The event type, must be `input_audio_buffer.speech_started`.
        #
        #   @return [Symbol, :"input_audio_buffer.speech_started"]
        required :type, const: :"input_audio_buffer.speech_started"

        # @!method initialize(audio_start_ms:, event_id:, item_id:, type: :"input_audio_buffer.speech_started")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::InputAudioBufferSpeechStartedEvent} for more details.
        #
        #   Sent by the server when in `server_vad` mode to indicate that speech has been
        #   detected in the audio buffer. This can happen any time audio is added to the
        #   buffer (unless speech is already detected). The client may want to use this
        #   event to interrupt audio playback or provide visual feedback to the user.
        #
        #   The client should expect to receive a `input_audio_buffer.speech_stopped` event
        #   when speech stops. The `item_id` property is the ID of the user message item
        #   that will be created when speech stops and will also be included in the
        #   `input_audio_buffer.speech_stopped` event (unless the client manually commits
        #   the audio buffer during VAD activation).
        #
        #   @param audio_start_ms [Integer] Milliseconds from the start of all audio written to the buffer during the
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the user message item that will be created when speech stops.
        #
        #   @param type [Symbol, :"input_audio_buffer.speech_started"] The event type, must be `input_audio_buffer.speech_started`.
      end
    end
  end
end
