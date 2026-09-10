# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionSubagentClosedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute subagent
        #   The subagent that was closed.
        #
        #   @return [OpenAI::Models::Beta::Subagent]
        required :subagent, -> { OpenAI::Beta::Subagent }

        # @!attribute type
        #   The type of the object. Always `agent.session.subagent.closed`.
        #
        #   @return [Symbol, :"agent.session.subagent.closed"]
        required :type, const: :"agent.session.subagent.closed"

        # @!method initialize(event_id:, subagent:, type: :"agent.session.subagent.closed")
        #   Emitted when a subagent is closed.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param subagent [OpenAI::Models::Beta::Subagent]
        #     The subagent that was closed.
        #
        #   @param type [Symbol, :"agent.session.subagent.closed"]
        #     The type of the object. Always `agent.session.subagent.closed`.
      end
    end
  end
end
