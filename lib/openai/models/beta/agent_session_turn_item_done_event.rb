# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionTurnItemDoneEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute item
        #   The completed output item.
        #
        #   @return [OpenAI::Models::Beta::AgentSessionAssistantMessage, OpenAI::Models::Beta::AgentReasoningItem, OpenAI::Models::Beta::AgentFunctionCallItem, OpenAI::Models::Beta::AgentMcpCallItem, OpenAI::Models::Beta::AgentWebSearchCallItem, OpenAI::Models::Beta::AgentCommandExecutionItem, OpenAI::Models::Beta::AgentCreateSubagentCallItem, OpenAI::Models::Beta::AgentSendSubagentInputCallItem, OpenAI::Models::Beta::AgentResumeSubagentCallItem, OpenAI::Models::Beta::AgentWaitForSubagentsCallItem, OpenAI::Models::Beta::AgentInterruptSubagentCallItem, OpenAI::Models::Beta::AgentCloseSubagentCallItem]
        required :item, union: -> { OpenAI::Beta::AgentOutputItem }

        # @!attribute output_index
        #   The index of the output item in the turn output.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute session_id
        #   The ID of the session associated with the event.
        #
        #   @return [String]
        required :session_id, String

        # @!attribute turn_id
        #   The ID of the turn associated with the event, when applicable.
        #
        #   @return [String, nil]
        required :turn_id, String, nil?: true

        # @!attribute type
        #   The type of the object. Always `agent.session.turn.item.done`.
        #
        #   @return [Symbol, :"agent.session.turn.item.done"]
        required :type, const: :"agent.session.turn.item.done"

        # @!method initialize(event_id:, item:, output_index:, session_id:, turn_id:, type: :"agent.session.turn.item.done")
        #   Emitted when an output item is complete.
        #
        #   @param event_id [String]
        #     The unique ID of the event.
        #
        #   @param item [OpenAI::Models::Beta::AgentSessionAssistantMessage, OpenAI::Models::Beta::AgentReasoningItem, OpenAI::Models::Beta::AgentFunctionCallItem, OpenAI::Models::Beta::AgentMcpCallItem, OpenAI::Models::Beta::AgentWebSearchCallItem, OpenAI::Models::Beta::AgentCommandExecutionItem, OpenAI::Models::Beta::AgentCreateSubagentCallItem, OpenAI::Models::Beta::AgentSendSubagentInputCallItem, OpenAI::Models::Beta::AgentResumeSubagentCallItem, OpenAI::Models::Beta::AgentWaitForSubagentsCallItem, OpenAI::Models::Beta::AgentInterruptSubagentCallItem, OpenAI::Models::Beta::AgentCloseSubagentCallItem]
        #     The completed output item.
        #
        #   @param output_index [Integer]
        #     The index of the output item in the turn output.
        #
        #   @param session_id [String]
        #     The ID of the session associated with the event.
        #
        #   @param turn_id [String, nil]
        #     The ID of the turn associated with the event, when applicable.
        #
        #   @param type [Symbol, :"agent.session.turn.item.done"]
        #     The type of the object. Always `agent.session.turn.item.done`.
      end
    end
  end
end
