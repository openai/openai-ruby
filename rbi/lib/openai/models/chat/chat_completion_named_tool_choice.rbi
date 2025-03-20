# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionNamedToolChoice < OpenAI::BaseModel
        sig { returns(OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function) }
        def function
        end

        sig do
          params(_: T.any(OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function, OpenAI::Util::AnyHash))
            .returns(T.any(OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function, OpenAI::Util::AnyHash))
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

        # Specifies a tool the model should use. Use to force the model to call a specific
        #   function.
        sig do
          params(function: OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function, type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(function:, type: :function)
        end

        sig { override.returns({function: OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function, type: Symbol}) }
        def to_hash
        end

        class Function < OpenAI::BaseModel
          # The name of the function to call.
          sig { returns(String) }
          def name
          end

          sig { params(_: String).returns(String) }
          def name=(_)
          end

          sig { params(name: String).returns(T.attached_class) }
          def self.new(name:)
          end

          sig { override.returns({name: String}) }
          def to_hash
          end
        end
      end
    end

    ChatCompletionNamedToolChoice = Chat::ChatCompletionNamedToolChoice
  end
end
