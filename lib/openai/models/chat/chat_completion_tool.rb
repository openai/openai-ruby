# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionTool < OpenAI::Internal::Type::BaseModel
        # @!attribute function
        #
        #   @return [OpenAI::Models::FunctionDefinition]
        required :function, -> { OpenAI::FunctionDefinition }

        # @!attribute type
        #   The type of the tool. Currently, only `function` is supported.
        #
        #   @return [Symbol, :function]
        required :type, const: :function

        # @!method initialize(function:, type: :function)
        #   @param function [OpenAI::Models::FunctionDefinition]
        #
        #   @param type [Symbol, :function] The type of the tool. Currently, only `function` is supported.
      end
    end

    ChatCompletionTool = Chat::ChatCompletionTool
  end
end
