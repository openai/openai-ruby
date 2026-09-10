# typed: strong

module OpenAI
  module Models

    module Beta

      # A function result represented as text or supported model-input content.
      module AgentFunctionCallOutputParam
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            String,
            T::Array[OpenAI::Beta::InputContentParam::Variants]
          )
        end

        sig { override.returns(T::Array[OpenAI::Beta::AgentFunctionCallOutputParam::Variants]) }
        def self.variants
        end

        InputContentParamArray = T.let(
          OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::InputContentParam],
          OpenAI::Internal::Type::Converter
        )

      end

    end

  end
end
