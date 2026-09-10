# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class SessionCloseEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The Live client event type. Always `session.close`.
        #
        #   @return [Symbol, :"session.close"]
        required :type, const: :"session.close"

        # @!attribute event_id
        #   Optional client identifier for correlating this command with a server event's
        #   client_event_id or error.client_event_id.
        #
        #   @return [String, nil]
        optional :event_id, String, nil?: true

        # @!method initialize(event_id: nil, type: :"session.close")
        #   Request that the Live session close. The terminal `session.closed` event
        #   contains the close reason and final usage.
        #
        #   @param event_id [String, nil]
        #     Optional client identifier for correlating this command with a server event's
        #     client_event_id or error.client_event_id.
        #
        #   @param type [Symbol, :"session.close"]
        #     The Live client event type. Always `session.close`.
      end
    end
  end
end
