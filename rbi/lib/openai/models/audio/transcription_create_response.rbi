# typed: strong

module OpenAI
  module Models
    module Audio
      # Represents a transcription response returned by model, based on the provided
      #   input.
      class TranscriptionCreateResponse < OpenAI::Union
        abstract!

        class << self
          sig { override.returns([OpenAI::Models::Audio::Transcription, OpenAI::Models::Audio::TranscriptionVerbose]) }
          def variants
          end
        end
      end
    end
  end
end
