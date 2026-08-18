# typed: strong

module OpenAI
  module Models
    ChatCompletionFunctionTool = Chat::ChatCompletionFunctionTool

    module Chat
      class ChatCompletionFunctionTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionFunctionTool,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(OpenAI::FunctionDefinition) }
        attr_reader :function

        sig { params(function: OpenAI::FunctionDefinition::OrHash).void }
        attr_writer :function

        # The type of the tool. Currently, only `function` is supported.
        sig { returns(Symbol) }
        attr_accessor :type

        # A function tool that can be used to generate a response.
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
