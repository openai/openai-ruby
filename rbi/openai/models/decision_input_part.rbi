# typed: strong

module OpenAI
  module Models

    # An inline image. External URLs and file IDs are not supported.
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
