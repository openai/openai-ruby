# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionTool < OpenAI::BaseModel
        sig { returns(OpenAI::Models::FunctionDefinition) }
        attr_reader :function

        sig { params(function: T.any(OpenAI::Models::FunctionDefinition, OpenAI::Internal::Util::AnyHash)).void }
        attr_writer :function

        # The type of the tool. Currently, only `function` is supported.
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(function: T.any(OpenAI::Models::FunctionDefinition, OpenAI::Internal::Util::AnyHash), type: Symbol)
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
