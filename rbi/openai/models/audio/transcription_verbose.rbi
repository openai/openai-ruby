# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionVerbose < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Audio::TranscriptionVerbose,
              OpenAI::Internal::AnyHash
            )
          end

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
        sig do
          returns(T.nilable(T::Array[OpenAI::Audio::TranscriptionSegment]))
        end
        attr_reader :segments

        sig do
          params(
            segments: T::Array[OpenAI::Audio::TranscriptionSegment::OrHash]
          ).void
        end
        attr_writer :segments

        # Extracted words and their corresponding timestamps.
        sig { returns(T.nilable(T::Array[OpenAI::Audio::TranscriptionWord])) }
        attr_reader :words

        sig do
          params(words: T::Array[OpenAI::Audio::TranscriptionWord::OrHash]).void
        end
        attr_writer :words

        # Represents a verbose json transcription response returned by model, based on the
        # provided input.
        sig do
          params(
            duration: Float,
            language: String,
            text: String,
            segments: T::Array[OpenAI::Audio::TranscriptionSegment::OrHash],
            words: T::Array[OpenAI::Audio::TranscriptionWord::OrHash]
          ).returns(T.attached_class)
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
        )
        end

        sig do
          override.returns(
            {
              duration: Float,
              language: String,
              text: String,
              segments: T::Array[OpenAI::Audio::TranscriptionSegment],
              words: T::Array[OpenAI::Audio::TranscriptionWord]
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
