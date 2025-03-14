# typed: strong

module OpenAI
  module Models
    module Audio
      # Represents a transcription response returned by model, based on the provided
      #   input.
      class TranscriptionCreateResponse < OpenAI::Union
        abstract!

        class << self
          # @api private
          sig do
            override
              .returns(
                [[NilClass, OpenAI::Models::Audio::Transcription], [NilClass, OpenAI::Models::Audio::TranscriptionVerbose]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
