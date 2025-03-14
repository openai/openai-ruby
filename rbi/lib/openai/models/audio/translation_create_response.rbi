# typed: strong

module OpenAI
  module Models
    module Audio
      class TranslationCreateResponse < OpenAI::Union
        abstract!

        class << self
          sig { override.returns([OpenAI::Models::Audio::Translation, OpenAI::Models::Audio::TranslationVerbose]) }
          def variants
          end
        end
      end
    end
  end
end
