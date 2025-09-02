# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class SessionUpdatedEvent < OpenAI::Internal::Type::BaseModel
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
        #   The event type, must be `session.updated`.
        #
        #   @return [Symbol, :"session.updated"]
        required :type, const: :"session.updated"

        # @!method initialize(event_id:, session:, type: :"session.updated")
        #   Returned when a session is updated with a `session.update` event, unless there
        #   is an error.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param session [OpenAI::Models::Realtime::RealtimeSession] Realtime session object.
        #
        #   @param type [Symbol, :"session.updated"] The event type, must be `session.updated`.
      end
    end
  end
end
