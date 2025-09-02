# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class TranscriptionSessionUpdate < OpenAI::Internal::Type::BaseModel
        # @!attribute session
        #   Realtime transcription session object configuration.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest]
        required :session, -> { OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest }

        # @!attribute type
        #   The event type, must be `transcription_session.update`.
        #
        #   @return [Symbol, :"transcription_session.update"]
        required :type, const: :"transcription_session.update"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!method initialize(session:, event_id: nil, type: :"transcription_session.update")
        #   Send this event to update a transcription session.
        #
        #   @param session [OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest] Realtime transcription session object configuration.
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param type [Symbol, :"transcription_session.update"] The event type, must be `transcription_session.update`.
      end
    end
  end
end
