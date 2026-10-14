# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class ThinkingAppendEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   Silent reasoning or progress context, limited to 500 tokens. It does not
        #   directly request speech, but can influence later speech and is not a secrecy
        #   boundary.
        #
        #   @return [String]
        required :content, String

        # @!attribute delegation_id
        #   Required, nullable. Set null for general session context, or use the ID from
        #   session.delegation.created for an existing client delegation. Non-null IDs are
        #   not accepted with Responses delegation.
        #
        #   @return [String, nil]
        required :delegation_id, String, nil?: true

        # @!attribute type
        #   The Live client event type. Always `session.thinking.append`.
        #
        #   @return [Symbol, :"session.thinking.append"]
        required :type, const: :"session.thinking.append"

        # @!attribute event_id
        #   Optional client identifier for correlating this command with a server event's
        #   client_event_id or error.client_event_id.
        #
        #   @return [String, nil]
        optional :event_id, String, nil?: true

        # @!method initialize(content:, delegation_id:, event_id: nil, type: :"session.thinking.append")
        #   Provide silent reasoning or progress context to the Live model, optionally for
        #   an existing client delegation.
        #
        #   @param content [String]
        #     Silent reasoning or progress context, limited to 500 tokens. It does not
        #     directly request speech, but can influence later speech and is not a secrecy
        #     boundary.
        #
        #   @param delegation_id [String, nil]
        #     Required, nullable. Set null for general session context, or use the ID from
        #     session.delegation.created for an existing client delegation. Non-null IDs are
        #     not accepted with Responses delegation.
        #
        #   @param event_id [String, nil]
        #     Optional client identifier for correlating this command with a server event's
        #     client_event_id or error.client_event_id.
        #
        #   @param type [Symbol, :"session.thinking.append"]
        #     The Live client event type. Always `session.thinking.append`.
      end
    end
  end
end
