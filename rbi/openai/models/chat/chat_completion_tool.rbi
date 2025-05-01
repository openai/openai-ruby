# typed: strong

module OpenAI
  module Models
    ChatCompletionTool = Chat::ChatCompletionTool

    module Chat
      class ChatCompletionTool < OpenAI::Internal::Type::BaseModel
        sig { returns(OpenAI::Models::FunctionDefinition) }
        attr_reader :function

        sig { params(function: T.any(OpenAI::Models::FunctionDefinition, OpenAI::Internal::AnyHash)).void }
        attr_writer :function

        # The type of the tool. Currently, only `function` is supported.
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(function: T.any(OpenAI::Models::FunctionDefinition, OpenAI::Internal::AnyHash), type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(
          function:,
          # The type of the tool. Currently, only `function` is supported.
          type: :function
        ); end
        sig { override.returns({function: OpenAI::Models::FunctionDefinition, type: Symbol}) }
        def to_hash; end
      end
    end
  end
end
