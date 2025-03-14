# typed: strong

module OpenAI
  module Models
    ChatCompletionNamedToolChoice = T.type_alias { Chat::ChatCompletionNamedToolChoice }

    module Chat
      class ChatCompletionNamedToolChoice < OpenAI::BaseModel
        sig { returns(OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function) }
        def function
        end

        sig do
          params(_: OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function)
            .returns(OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function)
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
  end
end
