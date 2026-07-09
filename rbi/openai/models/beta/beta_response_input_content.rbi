# typed: strong

module OpenAI
  module Models
    BetaResponseInputContent = Beta::BetaResponseInputContent

    module Beta
      # A text input to the model.
      module BetaResponseInputContent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseInputText,
              OpenAI::Beta::BetaResponseInputImage,
              OpenAI::Beta::BetaResponseInputFile
            )
          end

        sig do
          override.returns(
            T::Array[OpenAI::Beta::BetaResponseInputContent::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
