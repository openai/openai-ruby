# typed: strong

module OpenAI
  module Models

    # A text, image, or JSON content part in a question instruction.
    module DecisionQuestionInputPart
      extend OpenAI::Internal::Type::Union

      Variants = T.type_alias do
        T.any(
          OpenAI::DecisionQuestionInputText,
          OpenAI::DecisionQuestionInputImage,
          OpenAI::DecisionInputJSON
        )
      end

      sig { override.returns(T::Array[OpenAI::DecisionQuestionInputPart::Variants]) }
      def self.variants
      end

    end

  end
end
