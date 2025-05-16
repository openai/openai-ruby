# typed: strong

module OpenAI
  module Models
    module Audio
      module TranslationCreateResponse
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(OpenAI::Audio::Translation, OpenAI::Audio::TranslationVerbose)
          end

        sig do
          override.returns(
            T::Array[OpenAI::Models::Audio::TranslationCreateResponse::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
