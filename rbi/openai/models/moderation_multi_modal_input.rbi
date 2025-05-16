# typed: strong

module OpenAI
  module Models
    # An object describing an image to classify.
    module ModerationMultiModalInput
      extend OpenAI::Internal::Type::Union

      Variants =
        T.type_alias do
          T.any(OpenAI::ModerationImageURLInput, OpenAI::ModerationTextInput)
        end

      sig do
        override.returns(T::Array[OpenAI::ModerationMultiModalInput::Variants])
      end
      def self.variants
      end
    end
  end
end
