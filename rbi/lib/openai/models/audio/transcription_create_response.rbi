# typed: strong

module OpenAI
  module Models
    module Audio
      # Represents a transcription response returned by model, based on the provided
      #   input.
      class TranscriptionCreateResponse < OpenAI::Union
        abstract!

        Variants = type_template(:out) { {fixed: T.any(OpenAI::Models::Audio::Transcription, OpenAI::Models::Audio::TranscriptionVerbose)} }
      end
    end
  end
end
