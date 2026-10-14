# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationOutputTranscriptDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTranslationOutputTranscriptDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Append-only transcript text for the translated output audio.
        sig { returns(String) }
        attr_accessor :delta

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The event type, must be `session.output_transcript.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Timing metadata for stream alignment, derived from the translation frame when
        # available. It advances in 200 ms increments, but multiple transcript deltas may
        # share the same `elapsed_ms`. Treat it as alignment metadata, not a unique
        # transcript-delta identifier.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :elapsed_ms

        # Returned when translated transcript text is available.
        #
        # Transcript deltas are append-only text fragments. Clients should not insert
        # unconditional spaces between deltas.
        sig do
          params(
            delta: String,
            event_id: String,
            elapsed_ms: T.nilable(Integer),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Append-only transcript text for the translated output audio.
          delta:,
          # The unique ID of the server event.
          event_id:,
          # Timing metadata for stream alignment, derived from the translation frame when
          # available. It advances in 200 ms increments, but multiple transcript deltas may
          # share the same `elapsed_ms`. Treat it as alignment metadata, not a unique
          # transcript-delta identifier.
          elapsed_ms: nil,
          # The event type, must be `session.output_transcript.delta`.
          type: :"session.output_transcript.delta"
        )
        end

        sig do
          override.returns(
            {
              delta: String,
              event_id: String,
              type: Symbol,
              elapsed_ms: T.nilable(Integer)
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
