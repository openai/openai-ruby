# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionMessageToolCall < OpenAI::BaseModel
        # The ID of the tool call.
        sig { returns(String) }
        attr_accessor :id

        # The function that the model called.
        sig { returns(OpenAI::Models::Chat::ChatCompletionMessageToolCall::Function) }
        attr_reader :function

        sig do
          params(
            function: T.any(OpenAI::Models::Chat::ChatCompletionMessageToolCall::Function, OpenAI::Internal::Util::AnyHash)
          )
            .void
        end
        attr_writer :function

        # The type of the tool. Currently, only `function` is supported.
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(
            id: String,
            function: T.any(OpenAI::Models::Chat::ChatCompletionMessageToolCall::Function, OpenAI::Internal::Util::AnyHash),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, function:, type: :function)
        end

        sig do
          override
            .returns(
              {id: String, function: OpenAI::Models::Chat::ChatCompletionMessageToolCall::Function, type: Symbol}
            )
        end
        def to_hash
        end

        class Function < OpenAI::BaseModel
          # The arguments to call the function with, as generated by the model in JSON
          #   format. Note that the model does not always generate valid JSON, and may
          #   hallucinate parameters not defined by your function schema. Validate the
          #   arguments in your code before calling your function.
          sig { returns(String) }
          attr_accessor :arguments

          # The name of the function to call.
          sig { returns(String) }
          attr_accessor :name

          # The function that the model called.
          sig { params(arguments: String, name: String).returns(T.attached_class) }
          def self.new(arguments:, name:)
          end

          sig { override.returns({arguments: String, name: String}) }
          def to_hash
          end
        end
      end
    end

    ChatCompletionMessageToolCall = Chat::ChatCompletionMessageToolCall
  end
end
