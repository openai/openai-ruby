# typed: strong

module OpenAI
  module Models
    module Beta
      class AssistantToolChoice < OpenAI::BaseModel
        # The type of the tool. If type is `function`, the function name must be set
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Beta::AssistantToolChoiceFunction)) }
        def function
        end

        sig do
          params(_: OpenAI::Models::Beta::AssistantToolChoiceFunction)
            .returns(OpenAI::Models::Beta::AssistantToolChoiceFunction)
        end
        def function=(_)
        end

        # Specifies a tool the model should use. Use to force the model to call a specific
        #   tool.
        sig do
          params(type: Symbol, function: OpenAI::Models::Beta::AssistantToolChoiceFunction).returns(T.attached_class)
        end
        def self.new(type:, function: nil)
        end

        sig { override.returns({type: Symbol, function: OpenAI::Models::Beta::AssistantToolChoiceFunction}) }
        def to_hash
        end

        # The type of the tool. If type is `function`, the function name must be set
        class Type < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          FUNCTION = :function
          CODE_INTERPRETER = :code_interpreter
          FILE_SEARCH = :file_search
        end
      end
    end
  end
end
