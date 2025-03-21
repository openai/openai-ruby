# typed: strong

module OpenAI
  module Models
    module Audio
      module TranslationCreateResponse
        extend OpenAI::Union

        sig { override.returns([OpenAI::Models::Audio::Translation, OpenAI::Models::Audio::TranslationVerbose]) }
        def self.variants
        end
      end
    end
  end
end
