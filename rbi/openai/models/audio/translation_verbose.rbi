# typed: strong

module OpenAI
  module Models
    module Audio
      class TranslationVerbose < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The duration of the input audio.
        sig { returns(Float) }
        attr_accessor :duration

        # The language of the output translation (always `english`).
        sig { returns(String) }
        attr_accessor :language

        # The translated text.
        sig { returns(String) }
        attr_accessor :text

        # Segments of the translated text and their corresponding details.
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

        sig do
          params(
            duration: Float,
            language: String,
            text: String,
            segments: T::Array[OpenAI::Audio::TranscriptionSegment::OrHash]
          ).returns(T.attached_class)
        end
        def self.new(
          # The duration of the input audio.
          duration:,
          # The language of the output translation (always `english`).
          language:,
          # The translated text.
          text:,
          # Segments of the translated text and their corresponding details.
          segments: nil
        )
        end

        sig do
          override.returns(
            {
              duration: Float,
              language: String,
              text: String,
              segments: T::Array[OpenAI::Audio::TranscriptionSegment]
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
