# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class ResponseEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event
        #   The nested Responses streaming event. Dispatch on its type field. Response
        #   lifecycle snapshots omit input and clear instructions, tools, and output to keep
        #   messages small; consume granular output events for the generated content.
        #
        #   @return [Hash{Symbol=>Object}]
        required :event, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

        # @!attribute event_id
        #   The unique ID of the Live server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute type
        #   The event type, always `response.event`.
        #
        #   @return [Symbol, :"response.event"]
        required :type, const: :"response.event"

        # @!attribute client_event_id
        #   The event_id of the client command associated with this server event, when
        #   supplied.
        #
        #   @return [String, nil]
        optional :client_event_id, String

        # @!attribute delegation_id
        #   The Live delegation associated with the nested Responses event. May be null or
        #   omitted when the event cannot be correlated with a delegation.
        #
        #   @return [String, nil]
        optional :delegation_id, String, nil?: true

        # @!method initialize(event:, event_id:, client_event_id: nil, delegation_id: nil, type: :"response.event")
        #   A streaming Responses API event from a backend delegated to by the Live session.
        #   Use the outer delegation_id to associate the nested stream with its Live
        #   delegation.
        #
        #   @param event [Hash{Symbol=>Object}]
        #     The nested Responses streaming event. Dispatch on its type field. Response
        #     lifecycle snapshots omit input and clear instructions, tools, and output to keep
        #     messages small; consume granular output events for the generated content.
        #
        #   @param event_id [String]
        #     The unique ID of the Live server event.
        #
        #   @param client_event_id [String]
        #     The event_id of the client command associated with this server event, when
        #     supplied.
        #
        #   @param delegation_id [String, nil]
        #     The Live delegation associated with the nested Responses event. May be null or
        #     omitted when the event cannot be correlated with a delegation.
        #
        #   @param type [Symbol, :"response.event"]
        #     The event type, always `response.event`.
      end
    end
  end
end
