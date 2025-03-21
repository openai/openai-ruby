# typed: strong

module OpenAI
  module Models
    module Beta
      class AssistantToolChoice < OpenAI::BaseModel
        # The type of the tool. If type is `function`, the function name must be set
        sig { returns(OpenAI::Models::Beta::AssistantToolChoice::Type::OrSymbol) }
        def type
        end

        sig do
          params(_: OpenAI::Models::Beta::AssistantToolChoice::Type::OrSymbol)
            .returns(OpenAI::Models::Beta::AssistantToolChoice::Type::OrSymbol)
        end
        def type=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Beta::AssistantToolChoiceFunction)) }
        def function
        end

        sig do
          params(_: T.any(OpenAI::Models::Beta::AssistantToolChoiceFunction, OpenAI::Util::AnyHash))
            .returns(T.any(OpenAI::Models::Beta::AssistantToolChoiceFunction, OpenAI::Util::AnyHash))
        end
        def function=(_)
        end

        # Specifies a tool the model should use. Use to force the model to call a specific
        #   tool.
        sig do
          params(
            type: OpenAI::Models::Beta::AssistantToolChoice::Type::OrSymbol,
            function: T.any(OpenAI::Models::Beta::AssistantToolChoiceFunction, OpenAI::Util::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(type:, function: nil)
        end

        sig do
          override
            .returns(
              {
                type: OpenAI::Models::Beta::AssistantToolChoice::Type::OrSymbol,
                function: OpenAI::Models::Beta::AssistantToolChoiceFunction
              }
            )
        end
        def to_hash
        end

        # The type of the tool. If type is `function`, the function name must be set
        module Type
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::AssistantToolChoice::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::Beta::AssistantToolChoice::Type::TaggedSymbol) }

          FUNCTION = T.let(:function, OpenAI::Models::Beta::AssistantToolChoice::Type::TaggedSymbol)
          CODE_INTERPRETER =
            T.let(:code_interpreter, OpenAI::Models::Beta::AssistantToolChoice::Type::TaggedSymbol)
          FILE_SEARCH = T.let(:file_search, OpenAI::Models::Beta::AssistantToolChoice::Type::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::Beta::AssistantToolChoice::Type::TaggedSymbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
