# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class ConversationItemRetrieveEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the item to retrieve.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute type
        #   The event type, must be `conversation.item.retrieve`.
        #
        #   @return [Symbol, :"conversation.item.retrieve"]
        required :type, const: :"conversation.item.retrieve"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!method initialize(item_id:, event_id: nil, type: :"conversation.item.retrieve")
        #   Send this event when you want to retrieve the server's representation of a
        #   specific item in the conversation history. This is useful, for example, to
        #   inspect user audio after noise cancellation and VAD. The server will respond
        #   with a `conversation.item.retrieved` event, unless the item does not exist in
        #   the conversation history, in which case the server will respond with an error.
        #
        #   @param item_id [String] The ID of the item to retrieve.
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param type [Symbol, :"conversation.item.retrieve"] The event type, must be `conversation.item.retrieve`.
      end
    end
  end
end
