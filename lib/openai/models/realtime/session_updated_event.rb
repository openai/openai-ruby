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
        #   The session configuration.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateRequest, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest]
        required :session, union: -> { OpenAI::Realtime::SessionUpdatedEvent::Session }

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
        #   @param session [OpenAI::Models::Realtime::RealtimeSessionCreateRequest, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest] The session configuration.
        #
        #   @param type [Symbol, :"session.updated"] The event type, must be `session.updated`.

        # The session configuration.
        #
        # @see OpenAI::Models::Realtime::SessionUpdatedEvent#session
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
