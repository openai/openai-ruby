# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionVerbose < OpenAI::BaseModel
        # The duration of the input audio.
        sig { returns(Float) }
        def duration
        end

        sig { params(_: Float).returns(Float) }
        def duration=(_)
        end

        # The language of the input audio.
        sig { returns(String) }
        def language
        end

        sig { params(_: String).returns(String) }
        def language=(_)
        end

        # The transcribed text.
        sig { returns(String) }
        def text
        end

        sig { params(_: String).returns(String) }
        def text=(_)
        end

        # Segments of the transcribed text and their corresponding details.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Audio::TranscriptionSegment])) }
        def segments
        end

        sig do
          params(_: T::Array[T.any(OpenAI::Models::Audio::TranscriptionSegment, OpenAI::Util::AnyHash)])
            .returns(T::Array[T.any(OpenAI::Models::Audio::TranscriptionSegment, OpenAI::Util::AnyHash)])
        end
        def segments=(_)
        end

        # Extracted words and their corresponding timestamps.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Audio::TranscriptionWord])) }
        def words
        end

        sig do
          params(_: T::Array[T.any(OpenAI::Models::Audio::TranscriptionWord, OpenAI::Util::AnyHash)])
            .returns(T::Array[T.any(OpenAI::Models::Audio::TranscriptionWord, OpenAI::Util::AnyHash)])
        end
        def words=(_)
        end

        # Represents a verbose json transcription response returned by model, based on the
        #   provided input.
        sig do
          params(
            duration: Float,
            language: String,
            text: String,
            segments: T::Array[T.any(OpenAI::Models::Audio::TranscriptionSegment, OpenAI::Util::AnyHash)],
            words: T::Array[T.any(OpenAI::Models::Audio::TranscriptionWord, OpenAI::Util::AnyHash)]
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
