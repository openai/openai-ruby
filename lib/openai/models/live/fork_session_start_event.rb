# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class ForkSessionStartEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute session
        #   Overrides for a stored session after connecting to the fork WebSocket. An empty
        #   object inherits the stored configuration; do not supply a new model.
        #   audio.format applies only to the new WebSocket connection. client overrides are
        #   only supported for WebRTC forks.
        #
        #   @return [OpenAI::Models::Live::ForkSessionConfig]
        required :session, -> { OpenAI::Live::ForkSessionConfig }

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
        #   Start a Live session after connecting to a stored session’s fork WebSocket. Send
        #   an empty `session` object to use the stored configuration.
        #
        #   @param session [OpenAI::Models::Live::ForkSessionConfig]
        #     Overrides for a stored session after connecting to the fork WebSocket. An empty
        #     object inherits the stored configuration; do not supply a new model.
        #     audio.format applies only to the new WebSocket connection. client overrides are
        #     only supported for WebRTC forks.
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
