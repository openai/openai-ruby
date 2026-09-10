# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class SessionUpdatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the Live server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute session
        #   The resolved Live session configuration and server-assigned session metadata.
        #
        #   @return [OpenAI::Models::Live::SessionResource]
        required :session, -> { OpenAI::Live::SessionResource }

        # @!attribute type
        #   The event type, always `session.updated`.
        #
        #   @return [Symbol, :"session.updated"]
        required :type, const: :"session.updated"

        # @!attribute client_event_id
        #   The event_id of the client command associated with this server event, when
        #   supplied.
        #
        #   @return [String, nil]
        optional :client_event_id, String

        # @!method initialize(event_id:, session:, client_event_id: nil, type: :"session.updated")
        #   Returned when a Live session update is accepted. Contains the resolved session
        #   configuration after the update.
        #
        #   @param event_id [String]
        #     The unique ID of the Live server event.
        #
        #   @param session [OpenAI::Models::Live::SessionResource]
        #     The resolved Live session configuration and server-assigned session metadata.
        #
        #   @param client_event_id [String]
        #     The event_id of the client command associated with this server event, when
        #     supplied.
        #
        #   @param type [Symbol, :"session.updated"]
        #     The event type, always `session.updated`.
      end
    end
  end
end
