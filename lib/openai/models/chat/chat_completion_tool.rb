# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionTool < OpenAI::Internal::Type::BaseModel
        # @!attribute function
        #
        #   @return [OpenAI::Models::FunctionDefinition]
        required :function, -> { OpenAI::Models::FunctionDefinition }

        # @!attribute type
        #   The type of the tool. Currently, only `function` is supported.
        #
        #   @return [Symbol, :function]
        required :type, const: :function

        # @!parse
        #   # @param function [OpenAI::Models::FunctionDefinition]
        #   # @param type [Symbol, :function]
        #   #
        #   def initialize(function:, type: :function, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end

    ChatCompletionTool = Chat::ChatCompletionTool
  end
end
