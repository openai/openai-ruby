# typed: strong

module OpenAI
  module Models
    ChatCompletionAllowedToolChoice = Chat::ChatCompletionAllowedToolChoice

    module Chat
      class ChatCompletionAllowedToolChoice < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionAllowedToolChoice,
              OpenAI::Internal::AnyHash
            )
          end

        # Constrains the tools available to the model to a pre-defined set.
        sig { returns(OpenAI::Chat::ChatCompletionAllowedTools) }
        attr_reader :allowed_tools

        sig do
          params(
            allowed_tools: OpenAI::Chat::ChatCompletionAllowedTools::OrHash
          ).void
        end
        attr_writer :allowed_tools

        # Allowed tool configuration type. Always `allowed_tools`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Constrains the tools available to the model to a pre-defined set.
        sig do
          params(
            allowed_tools: OpenAI::Chat::ChatCompletionAllowedTools::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Constrains the tools available to the model to a pre-defined set.
          allowed_tools:,
          # Allowed tool configuration type. Always `allowed_tools`.
          type: :allowed_tools
        )
        end

        sig do
          override.returns(
            {
              allowed_tools: OpenAI::Chat::ChatCompletionAllowedTools,
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
