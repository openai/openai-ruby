# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class SessionStartEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute session
        #   Initial configuration for a primary WebSocket. Send session.start first and wait
        #   for session.started before application commands. WebRTC creation already starts
        #   the session; do not send this event again on its data channel.
        #
        #   @return [OpenAI::Models::Live::SessionConfig]
        required :session, -> { OpenAI::Live::SessionConfig }

        # @!attribute type
        #   The Live client event type. Always `session.start`.
        #
        #   @return [Symbol, :"session.start"]
        required :type, const: :"session.start"

        # @!attribute event_id
        #   Optional client identifier for correlating this command with a server event's
        #   client_event_id or error.client_event_id.
        #
        #   @return [String, nil]
        optional :event_id, String, nil?: true

        # @!method initialize(session:, event_id: nil, type: :"session.start")
        #   Start a Live session on a primary WebSocket. Send this event before other
        #   commands and wait for `session.started`.
        #
        #   @param session [OpenAI::Models::Live::SessionConfig]
        #     Initial configuration for a primary WebSocket. Send session.start first and wait
        #     for session.started before application commands. WebRTC creation already starts
        #     the session; do not send this event again on its data channel.
        #
        #   @param event_id [String, nil]
        #     Optional client identifier for correlating this command with a server event's
        #     client_event_id or error.client_event_id.
        #
        #   @param type [Symbol, :"session.start"]
        #     The Live client event type. Always `session.start`.
      end
    end
  end
end
