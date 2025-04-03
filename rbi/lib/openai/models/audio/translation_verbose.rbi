# typed: strong

module OpenAI
  module Models
    module Audio
      class TranslationVerbose < OpenAI::BaseModel
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
        sig { returns(T.nilable(T::Array[OpenAI::Models::Audio::TranscriptionSegment])) }
        attr_reader :segments

        sig do
          params(
            segments: T::Array[T.any(OpenAI::Models::Audio::TranscriptionSegment, OpenAI::Internal::Util::AnyHash)]
          )
            .void
        end
        attr_writer :segments

        sig do
          params(
            duration: Float,
            language: String,
            text: String,
            segments: T::Array[T.any(OpenAI::Models::Audio::TranscriptionSegment, OpenAI::Internal::Util::AnyHash)]
          )
            .returns(T.attached_class)
        end
        def self.new(duration:, language:, text:, segments: nil)
        end

        sig do
          override
            .returns(
              {duration: Float, language: String, text: String, segments: T::Array[OpenAI::Models::Audio::TranscriptionSegment]}
            )
        end
        def to_hash
        end
      end
    end
  end
end
