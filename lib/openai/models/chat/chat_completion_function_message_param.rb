# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # @deprecated
      class ChatCompletionFunctionMessageParam < OpenAI::BaseModel
        # @!attribute content
        #   The contents of the function message.
        #
        #   @return [String, nil]
        required :content, String, nil?: true

        # @!attribute name
        #   The name of the function to call.
        #
        #   @return [String]
        required :name, String

        # @!attribute role
        #   The role of the messages author, in this case `function`.
        #
        #   @return [Symbol, :function]
        required :role, const: :function

        # @!parse
        #   # @param content [String, nil]
        #   # @param name [String]
        #   # @param role [Symbol, :function]
        #   #
        #   def initialize(content:, name:, role: :function, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end

    ChatCompletionFunctionMessageParam = Chat::ChatCompletionFunctionMessageParam
  end
end
