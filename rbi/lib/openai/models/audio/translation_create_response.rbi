# typed: strong

module OpenAI
  module Models
    module Audio
      module TranslationCreateResponse
        extend OpenAI::Union

        Variants =
          type_template(:out) { {fixed: T.any(OpenAI::Models::Audio::Translation, OpenAI::Models::Audio::TranslationVerbose)} }

        class << self
          sig { override.returns([OpenAI::Models::Audio::Translation, OpenAI::Models::Audio::TranslationVerbose]) }
          def variants
          end
        end
      end
    end
  end
end
