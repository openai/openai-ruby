# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionNamedToolChoice < OpenAI::BaseModel
        # @!attribute function
        #
        #   @return [OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function]
        required :function, -> { OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function }

        # @!attribute type
        #   The type of the tool. Currently, only `function` is supported.
        #
        #   @return [Symbol, :function]
        required :type, const: :function

        # @!parse
        #   # Specifies a tool the model should use. Use to force the model to call a specific
        #   #   function.
        #   #
        #   # @param function [OpenAI::Models::Chat::ChatCompletionNamedToolChoice::Function]
        #   # @param type [Symbol, :function]
        #   #
        #   def initialize(function:, type: :function, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # @see OpenAI::Models::Chat::ChatCompletionNamedToolChoice#function
        class Function < OpenAI::BaseModel
          # @!attribute name
          #   The name of the function to call.
          #
          #   @return [String]
          required :name, String

          # @!parse
          #   # @param name [String]
          #   #
          #   def initialize(name:, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end
      end
    end

    ChatCompletionNamedToolChoice = Chat::ChatCompletionNamedToolChoice
  end
end
