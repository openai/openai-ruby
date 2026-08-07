# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationSessionCreatedEvent < OpenAI::Internal::Type::BaseModel
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
        #   The event type, must be `session.created`.
        #
        #   @return [Symbol, :"session.created"]
        required :type, const: :"session.created"

        # @!method initialize(event_id:, session:, type: :"session.created")
        #   Returned when a translation session is created. Emitted automatically when a new
        #   connection is established as the first server event. This event contains the
        #   default translation session configuration.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param session [OpenAI::Models::Realtime::RealtimeTranslationSession] The translation session configuration.
        #
        #   @param type [Symbol, :"session.created"] The event type, must be `session.created`.
      end
    end
  end
end
