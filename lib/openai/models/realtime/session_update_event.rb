# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class SessionUpdateEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute session
        #   Update the Realtime session. Choose either a realtime session or a transcription
        #   session.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateRequest, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest]
        required :session, union: -> { OpenAI::Realtime::SessionUpdateEvent::Session }

        # @!attribute type
        #   The event type, must be `session.update`.
        #
        #   @return [Symbol, :"session.update"]
        required :type, const: :"session.update"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event. This is an arbitrary
        #   string that a client may assign. It will be passed back if there is an error
        #   with the event, but the corresponding `session.updated` event will not include
        #   it.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!method initialize(session:, event_id: nil, type: :"session.update")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::SessionUpdateEvent} for more details.
        #
        #   Send this event to update the session’s configuration. The client may send this
        #   event at any time to update any field except for `voice` and `model`. `voice`
        #   can be updated only if there have been no other audio outputs yet.
        #
        #   When the server receives a `session.update`, it will respond with a
        #   `session.updated` event showing the full, effective configuration. Only the
        #   fields that are present in the `session.update` are updated. To clear a field
        #   like `instructions`, pass an empty string. To clear a field like `tools`, pass
        #   an empty array. To clear a field like `turn_detection`, pass `null`.
        #
        #   @param session [OpenAI::Models::Realtime::RealtimeSessionCreateRequest, OpenAI::Models::Realtime::RealtimeTranscriptionSessionCreateRequest] Update the Realtime session. Choose either a realtime
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event. This is an arbitrary s
        #
        #   @param type [Symbol, :"session.update"] The event type, must be `session.update`.

        # Update the Realtime session. Choose either a realtime session or a transcription
        # session.
        #
        # @see OpenAI::Models::Realtime::SessionUpdateEvent#session
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
