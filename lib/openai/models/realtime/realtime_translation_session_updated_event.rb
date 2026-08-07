# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationSessionUpdatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute session
        #   The translation session configuration.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranslationSession]
        required :session, -> { OpenAI::Realtime::RealtimeTranslationSession }

        # @!attribute type
        #   The event type, must be `session.updated`.
        #
        #   @return [Symbol, :"session.updated"]
        required :type, const: :"session.updated"

        # @!method initialize(event_id:, session:, type: :"session.updated")
        #   Returned when a translation session is updated with a `session.update` event,
        #   unless there is an error.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param session [OpenAI::Models::Realtime::RealtimeTranslationSession] The translation session configuration.
        #
        #   @param type [Symbol, :"session.updated"] The event type, must be `session.updated`.
      end
    end
  end
end
