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
        #   The session configuration.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateRequest, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest]
        required :session, union: -> { OpenAI::Realtime::SessionCreatedEvent::Session }

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
        #   @param session [OpenAI::Models::Realtime::RealtimeSessionCreateRequest, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest] The session configuration.
        #
        #   @param type [Symbol, :"session.created"] The event type, must be `session.created`.

        # The session configuration.
        #
        # @see OpenAI::Models::Realtime::SessionCreatedEvent#session
        module Session
          extend OpenAI::Internal::Type::Union

          # Realtime session object configuration.
          variant -> { OpenAI::Realtime::RealtimeSessionCreateRequest }

          # Realtime transcription session object configuration.
          variant -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Realtime::RealtimeSessionCreateRequest, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest)]
        end
      end
    end
  end
end
