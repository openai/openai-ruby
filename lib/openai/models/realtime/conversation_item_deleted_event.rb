# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ConversationItemDeletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #   The ID of the item that was deleted.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute type
        #   The event type, must be `conversation.item.deleted`.
        #
        #   @return [Symbol, :"conversation.item.deleted"]
        required :type, const: :"conversation.item.deleted"

        # @!method initialize(event_id:, item_id:, type: :"conversation.item.deleted")
        #   Returned when an item in the conversation is deleted by the client with a
        #   `conversation.item.delete` event. This event is used to synchronize the server's
        #   understanding of the conversation history with the client's view.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param item_id [String] The ID of the item that was deleted.
        #
        #   @param type [Symbol, :"conversation.item.deleted"] The event type, must be `conversation.item.deleted`.
      end
    end
  end
end
