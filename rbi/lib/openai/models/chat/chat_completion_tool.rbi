# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionTool < OpenAI::BaseModel
        sig { returns(OpenAI::Models::FunctionDefinition) }
        def function
        end

        sig do
          params(_: T.any(OpenAI::Models::FunctionDefinition, OpenAI::Util::AnyHash))
            .returns(T.any(OpenAI::Models::FunctionDefinition, OpenAI::Util::AnyHash))
        end
        def function=(_)
        end

        # The type of the tool. Currently, only `function` is supported.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig do
          params(function: T.any(OpenAI::Models::FunctionDefinition, OpenAI::Util::AnyHash), type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(function:, type: :function)
        end

        sig { override.returns({function: OpenAI::Models::FunctionDefinition, type: Symbol}) }
        def to_hash
        end
      end
    end

    ChatCompletionTool = Chat::ChatCompletionTool
  end
end
