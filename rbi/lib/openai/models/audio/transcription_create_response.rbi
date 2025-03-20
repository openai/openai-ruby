# typed: strong

module OpenAI
  module Models
    module Audio
      # Represents a transcription response returned by model, based on the provided
      #   input.
      module TranscriptionCreateResponse
        extend OpenAI::Union

        Variants =
          type_template(:out) { {fixed: T.any(OpenAI::Models::Audio::Transcription, OpenAI::Models::Audio::TranscriptionVerbose)} }
      end
    end
  end
end
