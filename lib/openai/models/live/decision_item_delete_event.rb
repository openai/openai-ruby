# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionItemDeleteEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #
        #   @return [String]
        required :item_id, String

        # @!attribute type
        #
        #   @return [Symbol, :"decision.item.delete"]
        required :type, const: :"decision.item.delete"

        # @!attribute event_id
        #   Optional client identifier for correlating this command with a server event's
        #   client_event_id or error.client_event_id.
        #
        #   @return [String, nil]
        optional :event_id, String, nil?: true

        # @!method initialize(item_id:, event_id: nil, type: :"decision.item.delete")
        #   Delete an input item from future decisions without starting an evaluation or
        #   changing Live voice context.
        #
        #   @param item_id [String]
        #
        #   @param event_id [String, nil]
        #     Optional client identifier for correlating this command with a server event's
        #     client_event_id or error.client_event_id.
        #
        #   @param type [Symbol, :"decision.item.delete"]
      end
    end
  end
end
