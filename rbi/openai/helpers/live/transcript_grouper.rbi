# typed: strong

module OpenAI
  module Models
    module Live
      class TranscriptGrouper
        class Segment < Data
          sig { returns(String) }
          attr_reader :id

          sig { returns(T.nilable(String)) }
          attr_reader :previous_id

          # :user or :assistant
          sig { returns(Symbol) }
          attr_reader :speaker

          sig { returns(String) }
          attr_reader :text

          sig { returns(Integer) }
          attr_reader :start_ms, :end_ms
        end

        class ClosedSegment < Data
          sig { returns(Segment) }
          attr_reader :segment

          # :speaker_change, :inactivity, :timestamp_reset, :session_closed or :manual
          sig { returns(Symbol) }
          attr_reader :reason
        end

        sig do
          params(
            on_segment_updated: T.nilable(T.proc.params(segment: Segment).void),
            on_segment_closed: T.nilable(T.proc.params(event: ClosedSegment).void),
            min_turn_separation_ms: T.any(Integer, Float),
            assistant_silence_ms: T.any(Integer, Float),
            backchannel_max_duration_ms: T.any(Integer, Float),
            backchannel_isolation_ms: T.any(Integer, Float),
            additional_acknowledgments: T::Array[String]
          )
            .returns(T.attached_class)
        end
        def self.new(
          on_segment_updated: nil,
          on_segment_closed: nil,
          min_turn_separation_ms: 500,
          assistant_silence_ms: 2000,
          backchannel_max_duration_ms: 1000,
          backchannel_isolation_ms: 2000,
          additional_acknowledgments: []
        )
        end

        sig { params(event: T.anything).void }
        def push(event)
        end

        sig { void }
        def close
        end
      end
    end
  end
end
