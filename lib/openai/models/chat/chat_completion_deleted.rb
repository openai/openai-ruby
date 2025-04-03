# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # @see OpenAI::Resources::Chat::Completions#delete
      class ChatCompletionDeleted < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the chat completion that was deleted.
        #
        #   @return [String]
        required :id, String

        # @!attribute deleted
        #   Whether the chat completion was deleted.
        #
        #   @return [Boolean]
        required :deleted, OpenAI::Internal::Type::BooleanModel

        # @!attribute object
        #   The type of object being deleted.
        #
        #   @return [Symbol, :"chat.completion.deleted"]
        required :object, const: :"chat.completion.deleted"

        # @!parse
        #   # @param id [String]
        #   # @param deleted [Boolean]
        #   # @param object [Symbol, :"chat.completion.deleted"]
        #   #
        #   def initialize(id:, deleted:, object: :"chat.completion.deleted", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end

    ChatCompletionDeleted = Chat::ChatCompletionDeleted
  end
end
