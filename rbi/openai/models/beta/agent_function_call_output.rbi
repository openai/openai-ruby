# typed: strong

module OpenAI
  module Models

    module Beta

      # The text or model-input content supplied as a function result.
      module AgentFunctionCallOutput
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            String,
            T::Array[OpenAI::Beta::InputContent::Variants]
          )
        end

        sig { override.returns(T::Array[OpenAI::Beta::AgentFunctionCallOutput::Variants]) }
        def self.variants
        end

        InputContentArray = T.let(
          OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::InputContent],
          OpenAI::Internal::Type::Converter
        )

      end

    end

  end
end
