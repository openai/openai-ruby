# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ConversationItemDeleteEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the item to delete.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute type
        #   The event type, must be `conversation.item.delete`.
        #
        #   @return [Symbol, :"conversation.item.delete"]
        required :type, const: :"conversation.item.delete"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!method initialize(item_id:, event_id: nil, type: :"conversation.item.delete")
        #   Send this event when you want to remove any item from the conversation history.
        #   The server will respond with a `conversation.item.deleted` event, unless the
        #   item does not exist in the conversation history, in which case the server will
        #   respond with an error.
        #
        #   @param item_id [String] The ID of the item to delete.
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param type [Symbol, :"conversation.item.delete"] The event type, must be `conversation.item.delete`.
      end
    end
  end
end
