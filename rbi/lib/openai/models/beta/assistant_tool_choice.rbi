# typed: strong

module OpenAI
  module Models
    module Beta
      class AssistantToolChoice < OpenAI::BaseModel
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

        sig do
          params(type: Symbol, function: OpenAI::Models::Beta::AssistantToolChoiceFunction).returns(T.attached_class)
        end
        def self.new(type:, function: nil)
        end

        sig { override.returns({type: Symbol, function: OpenAI::Models::Beta::AssistantToolChoiceFunction}) }
        def to_hash
        end

        class Type < OpenAI::Enum
          abstract!

          FUNCTION = :function
          CODE_INTERPRETER = :code_interpreter
          FILE_SEARCH = :file_search

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
