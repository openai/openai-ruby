# typed: strong

module OpenAI
  module Models
    ChatCompletionMessageToolCall = T.type_alias { Chat::ChatCompletionMessageToolCall }

    module Chat
      class ChatCompletionMessageToolCall < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        sig { returns(OpenAI::Models::Chat::ChatCompletionMessageToolCall::Function) }
        def function
        end

        sig do
          params(_: OpenAI::Models::Chat::ChatCompletionMessageToolCall::Function)
            .returns(OpenAI::Models::Chat::ChatCompletionMessageToolCall::Function)
        end
        def function=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig do
          params(id: String, function: OpenAI::Models::Chat::ChatCompletionMessageToolCall::Function, type: Symbol)
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
          sig { returns(String) }
          def arguments
          end

          sig { params(_: String).returns(String) }
          def arguments=(_)
          end

          sig { returns(String) }
          def name
          end

          sig { params(_: String).returns(String) }
          def name=(_)
          end

          sig { params(arguments: String, name: String).returns(T.attached_class) }
          def self.new(arguments:, name:)
          end

          sig { override.returns({arguments: String, name: String}) }
          def to_hash
          end
        end
      end
    end
  end
end
