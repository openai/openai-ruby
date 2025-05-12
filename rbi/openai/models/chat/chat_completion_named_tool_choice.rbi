# typed: strong

module OpenAI
  module Models
    ChatCompletionNamedToolChoice = Chat::ChatCompletionNamedToolChoice

    module Chat
      class ChatCompletionNamedToolChoice < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionNamedToolChoice,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(OpenAI::Chat::ChatCompletionNamedToolChoice::Function) }
        attr_reader :function

        sig do
          params(
            function:
              OpenAI::Chat::ChatCompletionNamedToolChoice::Function::OrHash
          ).void
        end
        attr_writer :function

        # The type of the tool. Currently, only `function` is supported.
        sig { returns(Symbol) }
        attr_accessor :type

        # Specifies a tool the model should use. Use to force the model to call a specific
        # function.
        sig do
          params(
            function:
              OpenAI::Chat::ChatCompletionNamedToolChoice::Function::OrHash,
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
            {
              function: OpenAI::Chat::ChatCompletionNamedToolChoice::Function,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Function < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Chat::ChatCompletionNamedToolChoice::Function,
                OpenAI::Internal::AnyHash
              )
            end

          # The name of the function to call.
          sig { returns(String) }
          attr_accessor :name

          sig { params(name: String).returns(T.attached_class) }
          def self.new(
            # The name of the function to call.
            name:
          )
          end

          sig { override.returns({ name: String }) }
          def to_hash
          end
        end
      end
    end
  end
end
