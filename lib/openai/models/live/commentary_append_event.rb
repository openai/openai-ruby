# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class CommentaryAppendEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute content
        #   Speakable context for the Live model, limited to 500 tokens. Use this for a
        #   result the model should communicate; use session.thinking.append for silent
        #   context.
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
        #   The Live client event type. Always `session.commentary.append`.
        #
        #   @return [Symbol, :"session.commentary.append"]
        required :type, const: :"session.commentary.append"

        # @!attribute event_id
        #   Optional client identifier for correlating this command with a server event's
        #   client_event_id or error.client_event_id.
        #
        #   @return [String, nil]
        optional :event_id, String, nil?: true

        # @!method initialize(content:, delegation_id:, event_id: nil, type: :"session.commentary.append")
        #   Provide context the Live model can communicate to the user, optionally for an
        #   existing client delegation.
        #
        #   @param content [String]
        #     Speakable context for the Live model, limited to 500 tokens. Use this for a
        #     result the model should communicate; use session.thinking.append for silent
        #     context.
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
        #   @param type [Symbol, :"session.commentary.append"]
        #     The Live client event type. Always `session.commentary.append`.
      end
    end
  end
end
