# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class TranscriptionSessionCreated < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute session
        #   A new Realtime transcription session configuration.
        #
        #   When a session is created on the server via REST API, the session object also
        #   contains an ephemeral key. Default TTL for keys is 10 minutes. This property is
        #   not present when a session is updated via the WebSocket API.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse]
        required :session, -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateResponse }

        # @!attribute type
        #   The event type, must be `transcription_session.created`.
        #
        #   @return [Symbol, :"transcription_session.created"]
        required :type, const: :"transcription_session.created"

        # @!method initialize(event_id:, session:, type: :"transcription_session.created")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::TranscriptionSessionCreated} for more details.
        #
        #   Returned when a transcription session is created.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param session [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateResponse] A new Realtime transcription session configuration.
        #
        #   @param type [Symbol, :"transcription_session.created"] The event type, must be `transcription_session.created`.
      end
    end
  end
end
