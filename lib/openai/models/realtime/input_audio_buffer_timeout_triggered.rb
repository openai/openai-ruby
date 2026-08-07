# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferTimeoutTriggered < OpenAI::Internal::Type::BaseModel
        # @!attribute audio_end_ms
        #   Millisecond offset of audio written to the input audio buffer at the time the
        #   timeout was triggered.
        #
        #   @return [Integer]
        required :audio_end_ms, Integer

        # @!attribute audio_start_ms
        #   Millisecond offset of audio written to the input audio buffer that was after the
        #   playback time of the last model response.
        #
        #   @return [Integer]
        required :audio_start_ms, Integer

        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the item associated with this segment.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute type
        #   The event type, must be `input_audio_buffer.timeout_triggered`.
        #
        #   @return [Symbol, :"input_audio_buffer.timeout_triggered"]
        required :type, const: :"input_audio_buffer.timeout_triggered"

        # @!method initialize(audio_end_ms:, audio_start_ms:, event_id:, item_id:, type: :"input_audio_buffer.timeout_triggered")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::InputAudioBufferTimeoutTriggered} for more details.
        #
        #   Returned when the Server VAD timeout is triggered for the input audio buffer.
        #   This is configured with `idle_timeout_ms` in the `turn_detection` settings of
        #   the session, and it indicates that there hasn't been any speech detected for the
        #   configured duration.
        #
        #   The `audio_start_ms` and `audio_end_ms` fields indicate the segment of audio
        #   after the last model response up to the triggering time, as an offset from the
        #   beginning of audio written to the input audio buffer. This means it demarcates
        #   the segment of audio that was silent and the difference between the start and
        #   end values will roughly match the configured timeout.
        #
        #   The empty audio will be committed to the conversation as an `input_audio` item
        #   (there will be a `input_audio_buffer.committed` event) and a model response will
        #   be generated. There may be speech that didn't trigger VAD but is still detected
        #   by the model, so the model may respond with something relevant to the
        #   conversation or a prompt to continue speaking.
        #
        #   @param audio_end_ms [Integer] Millisecond offset of audio written to the input audio buffer at the time the ti
        #
        #   @param audio_start_ms [Integer] Millisecond offset of audio written to the input audio buffer that was after the
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the item associated with this segment.
        #
        #   @param type [Symbol, :"input_audio_buffer.timeout_triggered"] The event type, must be `input_audio_buffer.timeout_triggered`.
      end
    end
  end
end
