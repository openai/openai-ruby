# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class InfoEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute code
        #   A machine-readable code for the notice, such as `data_channel_permissions`.
        #
        #   @return [String]
        required :code, String

        # @!attribute event_id
        #   The unique ID of the Live server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute message
        #   A human-readable explanation of the Live session notice.
        #
        #   @return [String]
        required :message, String

        # @!attribute type
        #   The event type, always `info`.
        #
        #   @return [Symbol, :info]
        required :type, const: :info

        # @!attribute client_event_id
        #   The event_id of the client command associated with this server event, when
        #   supplied.
        #
        #   @return [String, nil]
        optional :client_event_id, String

        # @!method initialize(code:, event_id:, message:, client_event_id: nil, type: :info)
        #   An informational notice about the Live session, such as the event permissions
        #   applied to a frontend data channel.
        #
        #   @param code [String]
        #     A machine-readable code for the notice, such as `data_channel_permissions`.
        #
        #   @param event_id [String]
        #     The unique ID of the Live server event.
        #
        #   @param message [String]
        #     A human-readable explanation of the Live session notice.
        #
        #   @param client_event_id [String]
        #     The event_id of the client command associated with this server event, when
        #     supplied.
        #
        #   @param type [Symbol, :info]
        #     The event type, always `info`.
      end
    end
  end
end
