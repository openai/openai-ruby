# typed: strong

module OpenAI
  module Models

    # An image provided as a base64 data URL or a publicly accessible HTTP(S) URL.
    # File IDs are not supported.
    module DecisionInputPart
      extend OpenAI::Internal::Type::Union

      Variants = T.type_alias do
        T.any(
          OpenAI::DecisionInputText,
          OpenAI::DecisionInputImage
        )
      end

      sig { override.returns(T::Array[OpenAI::DecisionInputPart::Variants]) }
      def self.variants
      end

    end

  end
end
