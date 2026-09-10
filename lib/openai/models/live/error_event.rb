# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class ErrorEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute error
        #   Details of the Live error and the client command that caused it, when known.
        #
        #   @return [OpenAI::Models::Live::Error]
        required :error, -> { OpenAI::Live::Error }

        # @!attribute event_id
        #   The unique ID of the Live server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute type
        #   The event type, always `error`.
        #
        #   @return [Symbol, :error]
        required :type, const: :error

        # @!attribute client_event_id
        #   The event_id of the client command associated with this server event, when
        #   supplied.
        #
        #   @return [String, nil]
        optional :client_event_id, String

        # @!method initialize(error:, event_id:, client_event_id: nil, type: :error)
        #   Reports an error in the Live session, such as an invalid client command. Use
        #   error.client_event_id, when present, to identify the command that caused the
        #   error.
        #
        #   @param error [OpenAI::Models::Live::Error]
        #     Details of the Live error and the client command that caused it, when known.
        #
        #   @param event_id [String]
        #     The unique ID of the Live server event.
        #
        #   @param client_event_id [String]
        #     The event_id of the client command associated with this server event, when
        #     supplied.
        #
        #   @param type [Symbol, :error]
        #     The event type, always `error`.
      end
    end
  end
end
