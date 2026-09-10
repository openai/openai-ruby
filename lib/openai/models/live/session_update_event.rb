# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class SessionUpdateEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute session
        #   Sparse delegation updates. Omitted settings retain their values. The delegation
        #   type cannot change, including resetting Responses delegation to null or client.
        #   Model, frontend instructions, audio, and startup input are immutable.
        #
        #   @return [OpenAI::Models::Live::SessionUpdateConfig]
        required :session, -> { OpenAI::Live::SessionUpdateConfig }

        # @!attribute type
        #   The Live client event type. Always `session.update`.
        #
        #   @return [Symbol, :"session.update"]
        required :type, const: :"session.update"

        # @!attribute event_id
        #   Optional client identifier for correlating this command with a server event's
        #   client_event_id or error.client_event_id.
        #
        #   @return [String, nil]
        optional :event_id, String, nil?: true

        # @!method initialize(session:, event_id: nil, type: :"session.update")
        #   Update the delegation settings of an active Live session. The server
        #   acknowledges accepted changes with `session.updated`.
        #
        #   @param session [OpenAI::Models::Live::SessionUpdateConfig]
        #     Sparse delegation updates. Omitted settings retain their values. The delegation
        #     type cannot change, including resetting Responses delegation to null or client.
        #     Model, frontend instructions, audio, and startup input are immutable.
        #
        #   @param event_id [String, nil]
        #     Optional client identifier for correlating this command with a server event's
        #     client_event_id or error.client_event_id.
        #
        #   @param type [Symbol, :"session.update"]
        #     The Live client event type. Always `session.update`.
      end
    end
  end
end
