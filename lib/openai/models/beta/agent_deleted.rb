# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Agents#delete
      class AgentDeleted < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The ID of the deleted agent.
        #
        #   @return [String]
        required :id, String

        # @!attribute deleted
        #   Whether the agent was deleted. Always `true`.
        #
        #   @return [Boolean]
        required :deleted, OpenAI::Internal::Type::Boolean

        # @!attribute object
        #   The object type. Always `agent.deleted`.
        #
        #   @return [Symbol, :"agent.deleted"]
        required :object, const: :"agent.deleted"

        # @!method initialize(id:, deleted:, object: :"agent.deleted")
        #   A deleted reusable agent.
        #
        #   @param id [String]
        #     The ID of the deleted agent.
        #
        #   @param deleted [Boolean]
        #     Whether the agent was deleted. Always `true`.
        #
        #   @param object [Symbol, :"agent.deleted"]
        #     The object type. Always `agent.deleted`.
      end
    end
  end
end
