# typed: strong

module OpenAI
  module Models
    ChatCompletionNamedToolChoiceCustom =
      Chat::ChatCompletionNamedToolChoiceCustom

    module Chat
      class ChatCompletionNamedToolChoiceCustom < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionNamedToolChoiceCustom,
              OpenAI::Internal::AnyHash
            )
          end

        sig do
          returns(OpenAI::Chat::ChatCompletionNamedToolChoiceCustom::Custom)
        end
        attr_reader :custom

        sig do
          params(
            custom:
              OpenAI::Chat::ChatCompletionNamedToolChoiceCustom::Custom::OrHash
          ).void
        end
        attr_writer :custom

        # For custom tool calling, the type is always `custom`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Specifies a tool the model should use. Use to force the model to call a specific
        # custom tool.
        sig do
          params(
            custom:
              OpenAI::Chat::ChatCompletionNamedToolChoiceCustom::Custom::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          custom:,
          # For custom tool calling, the type is always `custom`.
          type: :custom
        )
        end

        sig do
          override.returns(
            {
              custom: OpenAI::Chat::ChatCompletionNamedToolChoiceCustom::Custom,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Custom < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Chat::ChatCompletionNamedToolChoiceCustom::Custom,
                OpenAI::Internal::AnyHash
              )
            end

          # The name of the custom tool to call.
          sig { returns(String) }
          attr_accessor :name

          sig { params(name: String).returns(T.attached_class) }
          def self.new(
            # The name of the custom tool to call.
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
