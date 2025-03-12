# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionVerbose < OpenAI::BaseModel
        sig { returns(Float) }
        def duration
        end

        sig { params(_: Float).returns(Float) }
        def duration=(_)
        end

        sig { returns(String) }
        def language
        end

        sig { params(_: String).returns(String) }
        def language=(_)
        end

        sig { returns(String) }
        def text
        end

        sig { params(_: String).returns(String) }
        def text=(_)
        end

        sig { returns(T.nilable(T::Array[OpenAI::Models::Audio::TranscriptionSegment])) }
        def segments
        end

        sig do
          params(_: T::Array[OpenAI::Models::Audio::TranscriptionSegment])
            .returns(T::Array[OpenAI::Models::Audio::TranscriptionSegment])
        end
        def segments=(_)
        end

        sig { returns(T.nilable(T::Array[OpenAI::Models::Audio::TranscriptionWord])) }
        def words
        end

        sig do
          params(_: T::Array[OpenAI::Models::Audio::TranscriptionWord])
            .returns(T::Array[OpenAI::Models::Audio::TranscriptionWord])
        end
        def words=(_)
        end

        sig do
          params(
            duration: Float,
            language: String,
            text: String,
            segments: T::Array[OpenAI::Models::Audio::TranscriptionSegment],
            words: T::Array[OpenAI::Models::Audio::TranscriptionWord]
          )
            .returns(T.attached_class)
        end
        def self.new(duration:, language:, text:, segments: nil, words: nil)
        end

        sig do
          override
            .returns(
              {
                duration: Float,
                language: String,
                text: String,
                segments: T::Array[OpenAI::Models::Audio::TranscriptionSegment],
                words: T::Array[OpenAI::Models::Audio::TranscriptionWord]
              }
            )
        end
        def to_hash
        end
      end
    end
  end
end
