# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationInputTranscriptDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delta
        #   Append-only source-language transcript text.
        #
        #   @return [String]
        required :delta, String

        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute type
        #   The event type, must be `session.input_transcript.delta`.
        #
        #   @return [Symbol, :"session.input_transcript.delta"]
        required :type, const: :"session.input_transcript.delta"

        # @!attribute elapsed_ms
        #   Timing metadata for stream alignment, derived from the translation frame when
        #   available. It advances in 200 ms increments, but multiple transcript deltas may
        #   share the same `elapsed_ms`. Treat it as alignment metadata, not a unique
        #   transcript-delta identifier.
        #
        #   @return [Integer, nil]
        optional :elapsed_ms, Integer, nil?: true

        # @!method initialize(delta:, event_id:, elapsed_ms: nil, type: :"session.input_transcript.delta")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::RealtimeTranslationInputTranscriptDeltaEvent} for
        #   more details.
        #
        #   Returned when optional source-language transcript text is available. This event
        #   is emitted only when `audio.input.transcription` is configured.
        #
        #   Transcript deltas are append-only text fragments. Clients should not insert
        #   unconditional spaces between deltas.
        #
        #   @param delta [String] Append-only source-language transcript text.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param elapsed_ms [Integer, nil] Timing metadata for stream alignment, derived from the translation frame
        #
        #   @param type [Symbol, :"session.input_transcript.delta"] The event type, must be `session.input_transcript.delta`.
      end
    end
  end
end
