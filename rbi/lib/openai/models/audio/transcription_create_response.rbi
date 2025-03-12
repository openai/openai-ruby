# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionCreateResponse < OpenAI::Union
        abstract!

        class << self
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
