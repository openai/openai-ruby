# typed: strong

module OpenAI
  module Models

    module Audio

      class TranscriptionLanguage < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Audio::TranscriptionLanguage,
            OpenAI::Internal::AnyHash
          )
        end

        # The code of a language detected in the audio.
        sig { returns(String) }
        attr_accessor :code

        # A language detected in transcribed audio.
        sig do
          params(

            code: String
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The code of a language detected in the audio.

          code:
        )
        end

        sig do
          override.returns(
            {code: String}
          )
        end
        def to_hash
        end

      end

    end

  end
end
