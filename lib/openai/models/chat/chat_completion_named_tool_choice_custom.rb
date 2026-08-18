# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionNamedToolChoiceCustom < OpenAI::Internal::Type::BaseModel
        # @!attribute custom
        #
        #   @return [OpenAI::Models::Chat::ChatCompletionNamedToolChoiceCustom::Custom]
        required :custom, -> { OpenAI::Chat::ChatCompletionNamedToolChoiceCustom::Custom }

        # @!attribute type
        #   For custom tool calling, the type is always `custom`.
        #
        #   @return [Symbol, :custom]
        required :type, const: :custom

        # @!method initialize(custom:, type: :custom)
        #   Specifies a tool the model should use. Use to force the model to call a specific
        #   custom tool.
        #
        #   @param custom [OpenAI::Models::Chat::ChatCompletionNamedToolChoiceCustom::Custom]
        #
        #   @param type [Symbol, :custom] For custom tool calling, the type is always `custom`.

        # @see OpenAI::Models::Chat::ChatCompletionNamedToolChoiceCustom#custom
        class Custom < OpenAI::Internal::Type::BaseModel
          # @!attribute name
          #   The name of the custom tool to call.
          #
          #   @return [String]
          required :name, String

          # @!method initialize(name:)
          #   @param name [String] The name of the custom tool to call.
        end
      end
    end

    ChatCompletionNamedToolChoiceCustom = Chat::ChatCompletionNamedToolChoiceCustom
  end
end
