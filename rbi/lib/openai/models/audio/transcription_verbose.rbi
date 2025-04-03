# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionVerbose < OpenAI::BaseModel
        # The duration of the input audio.
        sig { returns(Float) }
        attr_accessor :duration

        # The language of the input audio.
        sig { returns(String) }
        attr_accessor :language

        # The transcribed text.
        sig { returns(String) }
        attr_accessor :text

        # Segments of the transcribed text and their corresponding details.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Audio::TranscriptionSegment])) }
        attr_reader :segments

        sig do
          params(
            segments: T::Array[T.any(OpenAI::Models::Audio::TranscriptionSegment, OpenAI::Internal::Util::AnyHash)]
          )
            .void
        end
        attr_writer :segments

        # Extracted words and their corresponding timestamps.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Audio::TranscriptionWord])) }
        attr_reader :words

        sig do
          params(words: T::Array[T.any(OpenAI::Models::Audio::TranscriptionWord, OpenAI::Internal::Util::AnyHash)])
            .void
        end
        attr_writer :words

        # Represents a verbose json transcription response returned by model, based on the
        #   provided input.
        sig do
          params(
            duration: Float,
            language: String,
            text: String,
            segments: T::Array[T.any(OpenAI::Models::Audio::TranscriptionSegment, OpenAI::Internal::Util::AnyHash)],
            words: T::Array[T.any(OpenAI::Models::Audio::TranscriptionWord, OpenAI::Internal::Util::AnyHash)]
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
