# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationOutputAudioDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   Base64-encoded translated audio data.
        #
        #   @return [String]
        required :delta, String

        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute type
        #   The event type, must be `session.output_audio.delta`.
        #
        #   @return [Symbol, :"session.output_audio.delta"]
        required :type, const: :"session.output_audio.delta"

        # @!attribute channels
        #   Number of audio channels.
        #
        #   @return [Integer, nil]
        optional :channels, Integer

        # @!attribute elapsed_ms
        #   Timing metadata for stream alignment, derived from the translation frame when
        #   available. Treat `elapsed_ms` as alignment metadata, not a unique event
        #   identifier.
        #
        #   @return [Integer, nil]
        optional :elapsed_ms, Integer, nil?: true

        # @!attribute format_
        #   Audio encoding for `delta`.
        #
        #   @return [Symbol, OpenAI::Models::Realtime::RealtimeTranslationOutputAudioDeltaEvent::Format, nil]
        optional :format_,
                 enum: -> { OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent::Format },
                 api_name: :format

        # @!attribute sample_rate
        #   Sample rate of the audio delta.
        #
        #   @return [Integer, nil]
        optional :sample_rate, Integer

        # @!method initialize(delta:, event_id:, channels: nil, elapsed_ms: nil, format_: nil, sample_rate: nil, type: :"session.output_audio.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeTranslationOutputAudioDeltaEvent} for more
        #   details.
        #
        #   Returned when translated output audio is available. Output audio deltas are 200
        #   ms frames of PCM16 audio.
        #
        #   @param delta [String] Base64-encoded translated audio data.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param channels [Integer] Number of audio channels.
        #
        #   @param elapsed_ms [Integer, nil] Timing metadata for stream alignment, derived from the translation frame
        #
        #   @param format_ [Symbol, OpenAI::Models::Realtime::RealtimeTranslationOutputAudioDeltaEvent::Format] Audio encoding for `delta`.
        #
        #   @param sample_rate [Integer] Sample rate of the audio delta.
        #
        #   @param type [Symbol, :"session.output_audio.delta"] The event type, must be `session.output_audio.delta`.

        # Audio encoding for `delta`.
        #
        # @see OpenAI::Models::Realtime::RealtimeTranslationOutputAudioDeltaEvent#format_
        module Format
          extend OpenAI::Internal::Type::Enum

          PCM16 = :pcm16

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
