# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionAllowedToolChoice < OpenAI::Internal::Type::BaseModel
        # @!attribute allowed_tools
        #   Constrains the tools available to the model to a pre-defined set.
        #
        #   @return [OpenAI::Models::Chat::ChatCompletionAllowedTools]
        required :allowed_tools, -> { OpenAI::Chat::ChatCompletionAllowedTools }

        # @!attribute type
        #   Allowed tool configuration type. Always `allowed_tools`.
        #
        #   @return [Symbol, :allowed_tools]
        required :type, const: :allowed_tools

        # @!method initialize(allowed_tools:, type: :allowed_tools)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Chat::ChatCompletionAllowedToolChoice} for more details.
        #
        #   Constrains the tools available to the model to a pre-defined set.
        #
        #   @param allowed_tools [OpenAI::Models::Chat::ChatCompletionAllowedTools] Constrains the tools available to the model to a pre-defined set.
        #
        #   @param type [Symbol, :allowed_tools] Allowed tool configuration type. Always `allowed_tools`.
      end
    end

    ChatCompletionAllowedToolChoice = Chat::ChatCompletionAllowedToolChoice
  end
end
