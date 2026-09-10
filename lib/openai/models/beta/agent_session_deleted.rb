# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionDeleted < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the deleted session.
        #
        #   @return [String]
        required :id, String

        # @!attribute deleted
        #   Whether the session has been removed from the public API. Always `true`.
        #   Physical cleanup may still be in progress.
        #
        #   @return [Boolean]
        required :deleted, OpenAI::Internal::Type::Boolean

        # @!attribute object
        #   The object type. Always `agent.session.deleted`.
        #
        #   @return [Symbol, :"agent.session.deleted"]
        required :object, const: :"agent.session.deleted"

        # @!method initialize(id:, deleted:, object: :"agent.session.deleted")
        #   A Managed Agents session removed from the public API. Physical cleanup may
        #   continue asynchronously.
        #
        #   @param id [String]
        #     The ID of the deleted session.
        #
        #   @param deleted [Boolean]
        #     Whether the session has been removed from the public API. Always `true`.
        #     Physical cleanup may still be in progress.
        #
        #   @param object [Symbol, :"agent.session.deleted"]
        #     The object type. Always `agent.session.deleted`.
      end
    end
  end
end
