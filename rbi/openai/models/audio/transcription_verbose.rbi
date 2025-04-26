# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionVerbose < OpenAI::Internal::Type::BaseModel
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
          params(segments: T::Array[T.any(OpenAI::Models::Audio::TranscriptionSegment, OpenAI::Internal::AnyHash)])
            .void
        end
        attr_writer :segments

        # Extracted words and their corresponding timestamps.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Audio::TranscriptionWord])) }
        attr_reader :words

        sig { params(words: T::Array[T.any(OpenAI::Models::Audio::TranscriptionWord, OpenAI::Internal::AnyHash)]).void }
        attr_writer :words

        # Represents a verbose json transcription response returned by model, based on the
        # provided input.
        sig do
          params(
            duration: Float,
            language: String,
            text: String,
            segments: T::Array[T.any(OpenAI::Models::Audio::TranscriptionSegment, OpenAI::Internal::AnyHash)],
            words: T::Array[T.any(OpenAI::Models::Audio::TranscriptionWord, OpenAI::Internal::AnyHash)]
          )
            .returns(T.attached_class)
        end
        def self.new(
          # The duration of the input audio.
          duration:,
          # The language of the input audio.
          language:,
          # The transcribed text.
          text:,
          # Segments of the transcribed text and their corresponding details.
          segments: nil,
          # Extracted words and their corresponding timestamps.
          words: nil
        ); end
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
        def to_hash; end
      end
    end
  end
end
