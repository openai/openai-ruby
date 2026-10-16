# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionItemDeletedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the Live server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item_id
        #
        #   @return [String]
        required :item_id, String

        # @!attribute type
        #
        #   @return [Symbol, :"decision.item.deleted"]
        required :type, const: :"decision.item.deleted"

        # @!attribute client_event_id
        #   The event_id of the client command associated with this server event, when
        #   supplied.
        #
        #   @return [String, nil]
        optional :client_event_id, String

        # @!method initialize(event_id:, item_id:, client_event_id: nil, type: :"decision.item.deleted")
        #   An input item was removed from future decisions.
        #
        #   @param event_id [String]
        #     The unique ID of the Live server event.
        #
        #   @param item_id [String]
        #
        #   @param client_event_id [String]
        #     The event_id of the client command associated with this server event, when
        #     supplied.
        #
        #   @param type [Symbol, :"decision.item.deleted"]
      end
    end
  end
end
