# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionNamedToolChoice < OpenAI::Internal::Type::BaseModel
        # @!attribute function
        #
        #   @return [OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function]
        required :function, -> { OpenAI::Chat::ChatCompletionNamedToolChoice::Function }

        # @!attribute type
        #   The type of the tool. Currently, only `function` is supported.
        #
        #   @return [Symbol, :function]
        required :type, const: :function

        # @!method initialize(function:, type: :function)
        #   Specifies a tool the model should use. Use to force the model to call a specific
        #   function.
        #
        #   @param function [OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function]
        #
        #   @param type [Symbol, :function] The type of the tool. Currently, only `function` is supported.

        # @see OpenAI::Models::Chat::ChatCompletionNamedToolChoice#function
        class Function < OpenAI::Internal::Type::BaseModel
          # @!attribute name
          #   The name of the function to call.
          #
          #   @return [String]
          required :name, String

          # @!method initialize(name:)
          #   @param name [String] The name of the function to call.
        end
      end
    end

    ChatCompletionNamedToolChoice = Chat::ChatCompletionNamedToolChoice
  end
end
