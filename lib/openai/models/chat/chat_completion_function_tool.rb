# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionFunctionTool < OpenAI::Internal::Type::BaseModel
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
        #   A function tool that can be used to generate a response.
        #
        #   @param function [OpenAI::Models::FunctionDefinition]
        #
        #   @param type [Symbol, :function] The type of the tool. Currently, only `function` is supported.
      end
    end

    ChatCompletionFunctionTool = Chat::ChatCompletionFunctionTool
  end
end
