# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class ResponseCreateEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The Live client event type. Always `response.create`.
        #
        #   @return [Symbol, :"response.create"]
        required :type, const: :"response.create"

        # @!attribute event_id
        #   Optional client identifier for correlating this command with a server event's
        #   client_event_id or error.client_event_id.
        #
        #   @return [String, nil]
        optional :event_id, String, nil?: true

        # @!method initialize(event_id: nil, type: :"response.create")
        #   Request a response from the Live session’s Responses backend, or continue a
        #   delegated response waiting for tool results. Requires Responses delegation.
        #
        #   @param event_id [String, nil]
        #     Optional client identifier for correlating this command with a server event's
        #     client_event_id or error.client_event_id.
        #
        #   @param type [Symbol, :"response.create"]
        #     The Live client event type. Always `response.create`.
      end
    end
  end
end
