# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class SessionUpdateEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute session
        #   Realtime session object configuration.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeSessionCreateRequest]
        required :session, -> { OpenAI::Realtime::RealtimeSessionCreateRequest }

        # @!attribute type
        #   The event type, must be `session.update`.
        #
        #   @return [Symbol, :"session.update"]
        required :type, const: :"session.update"

        # @!attribute event_id
        #   Optional client-generated ID used to identify this event.
        #
        #   @return [String, nil]
        optional :event_id, String

        # @!method initialize(session:, event_id: nil, type: :"session.update")
        #   Send this event to update the session’s default configuration. The client may
        #   send this event at any time to update any field, except for `voice`. However,
        #   note that once a session has been initialized with a particular `model`, it
        #   can’t be changed to another model using `session.update`.
        #
        #   When the server receives a `session.update`, it will respond with a
        #   `session.updated` event showing the full, effective configuration. Only the
        #   fields that are present are updated. To clear a field like `instructions`, pass
        #   an empty string.
        #
        #   @param session [OpenAI::Models::Realtime::RealtimeSessionCreateRequest] Realtime session object configuration.
        #
        #   @param event_id [String] Optional client-generated ID used to identify this event.
        #
        #   @param type [Symbol, :"session.update"] The event type, must be `session.update`.
      end
    end
  end
end
