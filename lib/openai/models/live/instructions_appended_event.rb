# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class InstructionsAppendedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute end_ms
        #   The end of this event on the Live session timeline, in milliseconds from the
        #   beginning of the session. For appended context, this can equal start_ms.
        #
        #   @return [Integer]
        required :end_ms, Integer

        # @!attribute event_id
        #   The unique ID of the Live server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute start_ms
        #   The start of this event on the Live session timeline, in milliseconds from the
        #   beginning of the session.
        #
        #   @return [Integer]
        required :start_ms, Integer

        # @!attribute type
        #   The event type, always `session.instructions.appended`.
        #
        #   @return [Symbol, :"session.instructions.appended"]
        required :type, const: :"session.instructions.appended"

        # @!attribute client_event_id
        #   The event_id of the client command associated with this server event, when
        #   supplied.
        #
        #   @return [String, nil]
        optional :client_event_id, String

        # @!method initialize(end_ms:, event_id:, start_ms:, client_event_id: nil, type: :"session.instructions.appended")
        #   Returned when a session.instructions.append command is accepted into the Live
        #   session timeline. Acknowledges the appended instructions without guaranteeing
        #   that the model has acted on them.
        #
        #   @param end_ms [Integer]
        #     The end of this event on the Live session timeline, in milliseconds from the
        #     beginning of the session. For appended context, this can equal start_ms.
        #
        #   @param event_id [String]
        #     The unique ID of the Live server event.
        #
        #   @param start_ms [Integer]
        #     The start of this event on the Live session timeline, in milliseconds from the
        #     beginning of the session.
        #
        #   @param client_event_id [String]
        #     The event_id of the client command associated with this server event, when
        #     supplied.
        #
        #   @param type [Symbol, :"session.instructions.appended"]
        #     The event type, always `session.instructions.appended`.
      end
    end
  end
end
