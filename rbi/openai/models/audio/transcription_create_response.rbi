# typed: strong

module OpenAI
  module Models
    module Audio
      # Represents a transcription response returned by model, based on the provided
      # input.
      module TranscriptionCreateResponse
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Audio::Transcription,
              OpenAI::Audio::TranscriptionVerbose
            )
          end

        sig do
          override.returns(
            T::Array[
              OpenAI::Models::Audio::TranscriptionCreateResponse::Variants
            ]
          )
        end
        def self.variants
        end
      end
    end
  end
end
