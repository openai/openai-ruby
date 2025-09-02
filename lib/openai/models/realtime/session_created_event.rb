# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class SessionCreatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute session
        #   Realtime session object.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeSession]
        required :session, -> { OpenAI::Realtime::RealtimeSession }

        # @!attribute type
        #   The event type, must be `session.created`.
        #
        #   @return [Symbol, :"session.created"]
        required :type, const: :"session.created"

        # @!method initialize(event_id:, session:, type: :"session.created")
        #   Returned when a Session is created. Emitted automatically when a new connection
        #   is established as the first server event. This event will contain the default
        #   Session configuration.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param session [OpenAI::Models::Realtime::RealtimeSession] Realtime session object.
        #
        #   @param type [Symbol, :"session.created"] The event type, must be `session.created`.
      end
    end
  end
end
