# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionTextSegmentEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Audio::TranscriptionTextSegmentEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Unique identifier for the segment.
        sig { returns(String) }
        attr_accessor :id

        # End timestamp of the segment in seconds.
        sig { returns(Float) }
        attr_accessor :end_

        # Speaker label for this segment.
        sig { returns(String) }
        attr_accessor :speaker

        # Start timestamp of the segment in seconds.
        sig { returns(Float) }
        attr_accessor :start

        # Transcript text for this segment.
        sig { returns(String) }
        attr_accessor :text

        # The type of the event. Always `transcript.text.segment`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a diarized transcription returns a completed segment with speaker
        # information. Only emitted when you
        # [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        # with `stream` set to `true` and `response_format` set to `diarized_json`.
        sig do
          params(
            id: String,
            end_: Float,
            speaker: String,
            start: Float,
            text: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Unique identifier for the segment.
          id:,
          # End timestamp of the segment in seconds.
          end_:,
          # Speaker label for this segment.
          speaker:,
          # Start timestamp of the segment in seconds.
          start:,
          # Transcript text for this segment.
          text:,
          # The type of the event. Always `transcript.text.segment`.
          type: :"transcript.text.segment"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              end_: Float,
              speaker: String,
              start: Float,
              text: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
