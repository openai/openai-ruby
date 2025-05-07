# typed: strong

module OpenAI
  module Models
    ChatCompletionTool = Chat::ChatCompletionTool

    module Chat
      class ChatCompletionTool < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        sig { returns(OpenAI::FunctionDefinition) }
        attr_reader :function

        sig { params(function: OpenAI::FunctionDefinition::OrHash).void }
        attr_writer :function

        # The type of the tool. Currently, only `function` is supported.
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(
            function: OpenAI::FunctionDefinition::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          function:,
          # The type of the tool. Currently, only `function` is supported.
          type: :function
        )
        end

        sig do
          override.returns(
            { function: OpenAI::FunctionDefinition, type: Symbol }
          )
        end
        def to_hash
        end
      end
    end
  end
end
