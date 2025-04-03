# typed: strong

module OpenAI
  module Models
    module Audio
      # Represents a transcription response returned by model, based on the provided
      #   input.
      module TranscriptionCreateResponse
        extend OpenAI::Internal::Type::Union

        sig { override.returns([OpenAI::Models::Audio::Transcription, OpenAI::Models::Audio::TranscriptionVerbose]) }
        def self.variants
        end
      end
    end
  end
end
