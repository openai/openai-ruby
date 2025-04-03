# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      class ChatCompletionStoreMessage < OpenAI::Models::Chat::ChatCompletionMessage
        # @!attribute id
        #   The identifier of the chat message.
        #
        #   @return [String]
        required :id, String

        # @!parse
        #   # A chat completion message generated by the model.
        #   #
        #   # @param id [String]
        #   #
        #   def initialize(id:, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end

    ChatCompletionStoreMessage = Chat::ChatCompletionStoreMessage
  end
end
