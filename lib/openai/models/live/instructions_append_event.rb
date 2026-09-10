# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class InstructionsAppendEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   Instruction text to append, limited to 500 tokens. This is a plain string, not
        #   an array of content parts.
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
        #   The Live client event type. Always `session.instructions.append`.
        #
        #   @return [Symbol, :"session.instructions.append"]
        required :type, const: :"session.instructions.append"

        # @!attribute event_id
        #   Optional client identifier for correlating this command with a server event's
        #   client_event_id or error.client_event_id.
        #
        #   @return [String, nil]
        optional :event_id, String, nil?: true

        # @!method initialize(content:, delegation_id:, event_id: nil, type: :"session.instructions.append")
        #   Append instructions to the Live conversation while it is running, optionally
        #   associating them with an existing client delegation.
        #
        #   @param content [String]
        #     Instruction text to append, limited to 500 tokens. This is a plain string, not
        #     an array of content parts.
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
        #   @param type [Symbol, :"session.instructions.append"]
        #     The Live client event type. Always `session.instructions.append`.
      end
    end
  end
end
